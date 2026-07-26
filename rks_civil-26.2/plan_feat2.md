# Project: rks_civil 信息系统扩展

> **修订版** — 基于原 ChatGPT plan 的全面审查与修正
> 整合进现有 `rks_civil` 数据包，而非独立 `newspaper` namespace。

---

## Goal

为 `rks_civil-26.2` 扩展轻量级信息系统，包括：

- **官方公告**（Notice）—— 管理员发布，全员可见
- **报纸**（News）—— 管理员发布的长篇新闻
- **自由交流**（Forum）—— 玩家自由发帖

强调：

- 生存服务器可用
- GUI 简洁
- 可维护
- 易扩展
- **不依赖聊天输入**（所有文本通过 Written Book 录入）
- 尽量利用新版 Dialog GUI（MC 26.2+）

---

# Architecture

采用 MVC 思路。

```
┌─────────────────────────────────┐
│            GUI Layer            │
│  ┌────────┐ ┌──────┐ ┌───────┐ │
│  │ Dialog │ │ Book │ │Tellraw│ │
│  │(优先)  │ │(兼容)│ │(fallback)│
│  └────────┘ └──────┘ └───────┘ │
└───────────────┬─────────────────┘
                │
┌───────────────▼─────────────────┐
│        Controller Layer         │
│  ┌──────────────────────────┐   │
│  │   news/*  (业务逻辑)      │   │
│  │   admin/* (管理功能)      │   │
│  │   submission/* (投稿)     │   │
│  └──────────────────────────┘   │
└───────────────┬─────────────────┘
                │
┌───────────────▼─────────────────┐
│         Storage Layer           │
│  storage rks_civil:main {       │
│      news: { ... }              │
│  }                              │
└───────────────┬─────────────────┘
                │
┌───────────────▼─────────────────┐
│         Render Layer            │
│  render/*  (统一渲染)           │
│  dialog/*  (Dialog 模型调用)    │
└─────────────────────────────────┘
```

**核心原则：**
- 所有数据存储于 `storage rks_civil:main`，不使用 scoreboard 保存文本
- GUI 不直接读取 storage，所有数据经过 Render 层
- 文本输入唯一入口：**Written Book（成书）**
- 所有复杂逻辑拆分为 ≤200 行的子函数

---

# Storage Design

## 位置

扩展到现有 `storage rks_civil:main`（不新建 namespace）：

```
storage rks_civil:main
├── areas: [...]         # 已有（区域系统）
└── news: { ... }        # 新增（信息系统）
```

## 结构

```json
{
    "areas": [ ... ],

    "news": {
        "meta": {
            "next_id": 1,
            "max_forum_posts": 50,
            "page_size": 5
        },

        "notices": [
            {
                "id": 1,
                "title": "服务器维护通知",
                "author": "Admin",
                "body": ["第一页内容", "第二页内容"],
                "timestamp": 1722000000,
                "pinned": false,
                "expire": 0
            }
        ],

        "articles": [
            {
                "id": 1,
                "title": "本周新闻摘要",
                "author": "编辑部",
                "body": ["段落1", "段落2", "段落3"],
                "timestamp": 1722000000,
                "category": "weekly",
                "pinned": false,
                "read_count": 0
            }
        ],

        "forum_posts": [
            {
                "id": 1,
                "author": "PlayerName",
                "body": "帖子内容...",
                "timestamp": 1722000000,
                "likes": 0
            }
        ],

        "submissions": [
            {
                "id": 1,
                "author": "PlayerName",
                "title": "投稿标题",
                "body": ["..."],
                "timestamp": 1722000000,
                "status": "pending"
            }
        ]
    }
}
```

## 设计要点

| 字段 | 说明 |
|------|------|
| `body` | **字符串数组**，每个元素 = 一页/一段。天然支持分页和 Dialog 翻页 |
| `meta.next_id` | 全局自增 ID，避免冲突 |
| `meta.max_forum_posts` | 论坛帖子上限，超出自动清理最旧的 |
| `pinned` | 置顶标记，置顶文章排在列表最前 |
| `expire` | Unix 时间戳，过期公告自动隐藏（0 = 永不过期） |
| `read_count` | 阅读计数，用于热度排行 |
| `status` | 投稿状态：`pending` / `approved` / `rejected` |
| `category` | 新闻分类：`weekly` / `event` / `guide` / `other` |

## 未来可扩展字段

```
likes           # 点赞数
comments[]      # 评论列表
tags[]          # 标签
last_edit       # 最后编辑时间
```

---

# 文本输入方案（关键设计）

## 问题

Minecraft 数据包无法直接在 GUI 中输入多行格式化文本。

## 解决方案：Book-based Input Pipeline

**这是整个系统的核心机制，必须先实现：**

```
┌──────────────────────────────────────────┐
│            文本输入流程                    │
│                                          │
│  ① 玩家/管理员 撰写 Written Book          │
│         ↓                                │
│  ② 将成书投入指定容器                     │
│     （如 spawn 的 trapped_chest）          │
│         ↓                                │
│  ③ tick 循环检测容器内容                  │
│     （每 20 tick 检测一次）                │
│         ↓                                │
│  ④ 读取书的 pages[] → 拼接为 body[]       │
│         ↓                                │
│  ⑤ 根据容器类型分流：                     │
│     · 公告投稿箱 → submissions (pending)  │
│     · 论坛发言箱 → forum_posts (直接发布)  │
│         ↓                                │
│  ⑥ 清空容器 + 返还空书 + tellraw 确认     │
└──────────────────────────────────────────┘
```

## 容器标识

用容器下方或旁边的 **marker entity** 的 `Tags` 区分功能：

| 容器用途 | Marker Tag | 行为 |
|----------|------------|------|
| 公告/新闻投稿箱 | `news_submit` | 投稿 → `submissions[]` → 待审核 |
| 论坛发言箱 | `forum_post` | 发言 → `forum_posts[]` → 直接发布 |

---

# Dialog GUI 设计

## Dialog 模型文件

MC 26.2 的 dialog 系统需要 JSON 模型文件，存放在：

```
data/rks_civil/dialog/
├── main_menu.json           # 主菜单
├── notice_list.json         # 公告列表
├── notice_read.json         # 公告阅读
├── news_list.json           # 新闻列表
├── news_read.json           # 新闻阅读
├── forum_list.json          # 论坛帖子列表
├── forum_read.json          # 论坛帖子阅读
├── submission_confirm.json  # 投稿确认
└── admin_menu.json          # 管理员菜单
```

## 交互实体

在 spawn 放置一个 **marker entity**（`/summon minecraft:marker`），Tag 为 `news_agent`，作为 dialog 的对话对象。玩家右键交互实体 → 弹出 dialog 菜单。

备选入口：`/trigger rks_civil:news`（打字少的情况）。

## 按钮布局约定

每屏最多 4 个按钮，固定布局：

```
┌──────────────────────────┐
│      [标题文本]           │
│                          │
│      [正文/列表内容]      │
│                          │
├──────────────────────────┤
│ [上一页]  [下一页]        │
│ [操作1]   [操作2/返回]    │
└──────────────────────────┘
```

- 列表页：4 个按钮 = `[上一页] [下一页] [选择项] [返回]`
- 阅读页：4 个按钮 = `[上一页] [下一页] [上一篇] [返回目录]`

---

# Module 1 — 基础框架扩展

## 目标

扩展现有 `rks_civil` 框架，而非新建 namespace。

## 实现内容

```
1. 扩展 load.mcfunction
   └── 初始化 storage rks_civil:main news（若不存在则创建空结构）
   └── 为所有在线玩家执行 join 扩展

2. 扩展 tick.mcfunction
   └── 每 20 tick 检测投稿容器（submission/detect）

3. 扩展 join.mcfunction
   └── 检查未读公告数量，如有则 tellraw 提醒

4. 新建 scoreboard objectives
   ├── rks_civil_news_page     dummy    # 当前页码
   ├── rks_civil_news_id       dummy    # 当前文章 ID
   ├── rks_civil_news_mode     dummy    # 当前模式 (1=notice 2=news 3=forum)
   └── trigger_rks_news        trigger  # 玩家入口 /trigger rks_civil:news
```

## 新增文件

```
data/rks_civil/function/news/
├── init.mcfunction         # storage 初始化
└── menu.mcfunction         # 主菜单入口（由 trigger 调用）
```

## 验证标准

```
/trigger rks_civil:news     → 打开主菜单（tellraw 版本先可用）
/function rks_civil:news/menu  → 同上
storage rks_civil:main news  → 存在且结构正确
```

---

# Module 2 — 文本输入系统（投稿管道）

> ⚠️ **优先级提升**：这是整个系统的基础设施，必须先于任何 GUI 业务逻辑完成。

## 目标

实现 Book → 容器 → storage 的完整管道。

## 实现内容

### 2.1 容器检测（tick 中）

```
submission/detect.mcfunction
├── 遍历所有带 news_submit 或 forum_post tag 的 marker entity
├── 获取 marker 下方/旁边的容器方块
├── 检测容器中是否有 written_book
├── 有则 → submission/read_book（宏）
└── 节流：每 20 tick 执行一次
```

### 2.2 书籍内容读取（宏）

```
submission/read_book.mcfunction
├── 参数：$(container_pos), $(marker_tag)
├── /data get 容器的 Items[0].components.pages
├── 过滤 page 的 JSON text → 提取纯文本
├── 拼接为 body[] 数组
├── 根据 marker_tag 路由：
│   ├── news_submit → 存入 submissions[] (status=pending)
│   └── forum_post  → 存入 forum_posts[]（直接发布，含上限裁剪）
├── 清空容器
├── 给予作者一本空书（book_and_quill）
└── tellraw 作者 "投稿已收到！" 或 "发言已发布！"
```

### 2.3 论坛上限裁剪

```
forum_posts 超过 meta.max_forum_posts 时：
  → 删除最旧的帖子（按 timestamp 排序）
  → 保留最新 max_forum_posts 条
```

## 新增文件

```
data/rks_civil/function/submission/
├── detect.mcfunction       # 容器检测主逻辑
├── read_book.mcfunction    # 书籍读取（宏）
├── process.mcfunction      # 分流处理（宏）
└── cleanup.mcfunction      # 旧帖清理
```

---

# Module 3 — GUI 框架

## 目标

实现统一 GUI 入口和主菜单，使用 Dialog 优先、Tellraw fallback。

## 主菜单

```
┌──────────────────────┐
│                      │
│     📰 世界日报       │
│                      │
│  [📢 公告]           │
│  [📰 报纸]           │
│  [💬 交流区]         │
│  [❌ 关闭]           │
│                      │
└──────────────────────┘
```

## 导航规范

所有子菜单必须支持：
- **返回**：回到上一级菜单
- **关闭**：退出整个 GUI
- 通过 scoreboard `rks_civil_news_page` 和 `rks_civil_news_mode` 追踪导航状态

## 实现内容

```
dialog/*.json           # Dialog 模型文件（静态布局）
news/menu.mcfunction    # 主菜单逻辑（判断 entrance → 调用 dialog）
news/nav/
├── back.mcfunction     # 统一返回逻辑
├── close.mcfunction    # 统一关闭逻辑
└── paginate.mcfunction # 统一翻页逻辑
```

## 新增文件

```
data/rks_civil/dialog/
├── main_menu.json
├── notice_list.json
├── notice_read.json
├── news_list.json
├── news_read.json
├── forum_list.json
├── forum_read.json
└── admin_menu.json

data/rks_civil/function/news/nav/
├── back.mcfunction
├── close.mcfunction
└── paginate.mcfunction

data/rks_civil/function/render/
├── list.mcfunction      # 通用列表渲染器
├── article.mcfunction   # 通用文章渲染器
└── page.mcfunction      # 通用分页渲染器
```

---

# Module 4 — 公告系统

## 目标

管理员发布公告 → 玩家浏览列表 → 阅读正文。

## 功能

- 公告列表（按 pinned ↓ → timestamp ↓ 排序）
- 分页浏览（每页 5 条）
- 点击阅读正文（支持多页翻页）
- 返回列表
- **置顶**公告优先显示，带 `📌` 标记
- **过期**公告自动隐藏（`expire > 0 && expire < now`）

## 实现内容

```
news/notice/
├── list.mcfunction          # 公告列表入口
├── list_step.mcfunction     # 宏递归遍历（带分页截断）
├── read.mcfunction          # 阅读单条公告
└── read_page.mcfunction     # 阅读翻页（body[] 内翻页）
```

## 验证标准

```
玩家打开主菜单 → 点击「公告」→ 看到公告列表（分页）
→ 点击某条公告 → 看到正文（可翻页）→ 返回列表 → 返回主菜单
```

---

# Module 5 — 报纸系统

## 目标

新闻浏览，支持分类、上一篇/下一篇。

## 功能

- 新闻标题列表（按时间倒序）
- 分页浏览（每页 5 条）
- 点击进入正文（多页翻页）
- **上一篇 / 下一篇**（在当前列表上下文中导航）
- 返回目录
- 阅读计数 +1（`read_count`）

## 实现内容

```
news/newspaper/
├── list.mcfunction          # 新闻列表入口
├── list_step.mcfunction     # 宏递归遍历
├── read.mcfunction          # 阅读单篇新闻
├── read_page.mcfunction     # 正文翻页
├── prev.mcfunction          # 上一篇
└── next.mcfunction          # 下一篇
```

## 验证标准

```
主菜单 → 「报纸」→ 新闻列表 → 点击 → 阅读正文
→ 「下一篇」→ 下一篇正文 → 「返回目录」→ 列表
```

---

# Module 6 — 交流区

## 目标

轻量级论坛，玩家自由发帖、浏览。

## 功能

- 帖子列表（按时间倒序，最新 N 条）
- 分页浏览（每页 5 条）
- 阅读帖子正文
- 返回列表
- 自动清理旧帖（超过 `max_forum_posts` 条）

## 实现内容

```
news/forum/
├── list.mcfunction          # 帖子列表入口
├── list_step.mcfunction     # 宏递归遍历
├── read.mcfunction          # 阅读单条帖子
└── cleanup.mcfunction       # 旧帖清理（tick 中定期触发）
```

## 验证标准

```
玩家写书 → 投入论坛发言箱 → tellraw "发言已发布"
→ 其他玩家打开主菜单 → 「交流区」→ 看到新帖子 → 点击阅读
```

---

# Module 7 — 管理功能

## 目标

扩展已有 `admin_panel` 系统，增加新闻管理入口。

## 入口

```
方式1：手持管理面板 carrot_on_a_stick 右键
        → admin_panel/open → 新增「📰 新闻管理」按钮

方式2：/function rks_civil:admin/news/menu
```

## 管理菜单

```
┌──────────────────────┐
│   📰 新闻管理         │
│                      │
│  [➕ 新增公告]        │
│  [📝 发布新闻]        │
│  [📋 审核投稿]        │
│  [🗑 删除文章]        │
│  [🧹 清空交流区]      │
│  [↩ 返回]            │
└──────────────────────┘
```

## 功能详情

### 7.1 新增公告 / 发布新闻

```
管理员写书 → 投入「公告投稿箱」→ 自动存入 submissions[] (pending)
→ 管理菜单 → 「审核投稿」→ 预览 → 「通过」
→ 自动从 submissions[] 移至 notices[] 或 articles[]
```

### 7.2 审核投稿

```
审核列表（分页）：
  [标题] by [作者] | [通过] [拒绝]

通过：status → approved，移至对应列表
拒绝：status → rejected，tellraw 通知作者，可选附言
```

### 7.3 删除文章

```
选择类型（公告/新闻/帖子）→ 列表 → 选择条目 → 确认删除
```

### 7.4 清空交流区

```
二次确认 → 清空 forum_posts[]
```

## 新增文件

```
data/rks_civil/function/admin/news/
├── menu.mcfunction          # 新闻管理菜单
├── review.mcfunction        # 审核投稿列表
├── review_step.mcfunction   # 审核遍历（宏）
├── approve.mcfunction       # 通过投稿（宏）
├── reject.mcfunction        # 拒绝投稿（宏）
├── delete.mcfunction        # 删除文章
├── delete_confirm.mcfunction# 删除确认（宏）
└── clear_forum.mcfunction   # 清空交流区
```

---

# Module 8 — 渲染与导航（统一）

## 目标

所有 GUI 使用统一的 Render + Nav 逻辑，避免代码复制。

## Render 层

```
render/
├── list.mcfunction          # 通用列表渲染
│   参数：$(type), $(page)
│   行为：从 storage 读取对应列表，计算分页，生成 tellraw/dialog 数据
│
├── article.mcfunction       # 通用文章渲染
│   参数：$(type), $(id), $(body_page)
│   行为：从 storage 读取单篇文章，按 body[] 分页渲染
│
└── page.mcfunction          # 通用分页逻辑
    参数：$(total), $(page), $(page_size)
    行为：计算总页数，生成分页按钮
```

## Nav 层

```
news/nav/
├── back.mcfunction          # 统一返回（根据 mode + page 栈）
├── close.mcfunction         # 统一关闭（重置所有临时 scoreboard）
└── paginate.mcfunction      # 统一翻页（下一页/上一页）
```

## 关键原则

- GUI 函数（`gui/*` 或 `dialog/*`）只负责**展示**
- Render 函数负责**从 storage 构建展示数据**
- Nav 函数负责**状态管理**（页码、模式、浏览历史）
- Controller 函数（`news/*`）负责**业务逻辑**

---

# Module 9 — 持久化与容错

## 目标

确保数据在任何情况下不丢失。

## 覆盖场景

| 场景 | 要求 | 机制 |
|------|------|------|
| `/reload` | 数据保留 | storage 数据不受 reload 影响 |
| 服务器重启 | 数据保留 | storage 随世界存档持久化 |
| 玩家下线 | 状态清空 | join 时重置该玩家的临时 scoreboard |
| load 重入 | 不覆盖现有数据 | `init.mcfunction` 仅在 key 不存在时写入默认值 |
| storage 损坏 | 自动修复 | 读取时做 null-check，缺失字段补默认值 |
| 投稿容器损坏 | 不丢书 | 检测到容器被破坏时，掉落其中的书 |

## 实现

```
news/init.mcfunction:
  execute unless data storage rks_civil:main news
    run data modify storage rks_civil:main news set value {meta:{...}, ...}

system/repair.mcfunction (可选):
  # 一键修复缺失字段
  ...
```

---

# 修订后的目录结构

```
data/rks_civil/function/
├── load.mcfunction                  # 扩展
├── tick.mcfunction                  # 扩展
├── join.mcfunction                  # 扩展
│
├── area/                            # 已有（不变）
├── admin_panel/                     # 已有 + 扩展
│   ├── open.mcfunction              # 扩展：增加新闻管理入口
│   ├── dashboard.mcfunction
│   ├── areas.mcfunction
│   └── give.mcfunction
│
├── news/                            # 新增：业务逻辑
│   ├── init.mcfunction
│   ├── menu.mcfunction
│   ├── notice/
│   │   ├── list.mcfunction
│   │   ├── list_step.mcfunction
│   │   ├── read.mcfunction
│   │   └── read_page.mcfunction
│   ├── newspaper/
│   │   ├── list.mcfunction
│   │   ├── list_step.mcfunction
│   │   ├── read.mcfunction
│   │   ├── read_page.mcfunction
│   │   ├── prev.mcfunction
│   │   └── next.mcfunction
│   ├── forum/
│   │   ├── list.mcfunction
│   │   ├── list_step.mcfunction
│   │   ├── read.mcfunction
│   │   └── cleanup.mcfunction
│   └── nav/
│       ├── back.mcfunction
│       ├── close.mcfunction
│       └── paginate.mcfunction
│
├── submission/                      # 新增：投稿管道
│   ├── detect.mcfunction
│   ├── read_book.mcfunction
│   ├── process.mcfunction
│   └── cleanup.mcfunction
│
├── admin/news/                      # 新增：新闻管理
│   ├── menu.mcfunction
│   ├── review.mcfunction
│   ├── review_step.mcfunction
│   ├── approve.mcfunction
│   ├── reject.mcfunction
│   ├── delete.mcfunction
│   ├── delete_confirm.mcfunction
│   └── clear_forum.mcfunction
│
└── render/                          # 新增：统一渲染器
    ├── list.mcfunction
    ├── article.mcfunction
    └── page.mcfunction

data/rks_civil/dialog/               # 新增：Dialog 模型
├── main_menu.json
├── notice_list.json
├── notice_read.json
├── news_list.json
├── news_read.json
├── forum_list.json
├── forum_read.json
├── admin_menu.json
└── submission_confirm.json
```

---

# 修订后的开发阶段

```
Phase 1: 基础框架 + 文本管道
├── Module 1: 基础框架扩展（load/tick/join/storage/trigger）
└── Module 2: 文本输入系统（Book → 容器 → storage）

Phase 2: 最小可用产品
├── Module 3: GUI 框架（Dialog 模型 + 主菜单）
├── Module 4: 公告系统（管理员发 + 玩家看）
└── Module 8: 渲染与导航（随 Module 3/4 同步开发）

Phase 3: 功能扩展
├── Module 5: 报纸系统
├── Module 6: 交流区
└── Module 7: 管理功能（审核/删除/清空）

Phase 4: 体验优化
├── Module 9: 持久化与容错
├── 交互实体（spawn NPC 右键触发 dialog）
├── 订阅通知（上线未读提醒）
├── 智能公告过期
└── 彩蛋号外（事件触发自动新闻）
```

---

# 新奇想法（Future Ideas）

| 想法 | 说明 | 优先级 |
|------|------|--------|
| 📮 **实体邮筒** | spawn 放置 trapped_chest 作为"邮筒"，更有沉浸感 | ⭐⭐⭐ |
| 🗞️ **报纸实物** | 管理员发布后，在 lectern 自动生成一本可翻阅的成书 | ⭐⭐⭐ |
| 🔔 **订阅通知** | 玩家可选订阅，新内容上线时 tellraw 提醒 | ⭐⭐⭐ |
| 📊 **热帖排行** | sidebar 展示本周阅读量 TOP 5 | ⭐⭐ |
| 🎨 **事件号外** | 首次击杀末影龙等事件自动生成号外新闻 | ⭐⭐ |
| 🏷️ **智能过期** | 公告设 expire 时间，到期自动归档 | ⭐⭐⭐ |
| 🎫 **投票系统** | 公告内嵌投票，dialog 按钮选择 | ⭐ |
| 📂 **分类筛选** | 新闻按 category 筛选显示 | ⭐⭐ |
| 💬 **评论系统** | 文章下方允许玩家评论（复用 forum 管道） | ⭐ |
| 🌐 **多语言** | 根据玩家客户端语言显示不同版本 | ⭐ |

---

# 与原计划的差异总结

| 方面 | 原计划 | 修订后 |
|------|--------|--------|
| Namespace | `newspaper:` 独立 | 整合进 `rks_civil:` |
| Storage | 独立 `newspaper:data` | 扩展 `rks_civil:main` |
| 文本输入 | 未明确 | Written Book → 容器管道（核心机制） |
| body 字段 | 单字符串 | 字符串数组（天然分页） |
| Dialog 模型 | 未提及 | 需要 `dialog/*.json` 模型文件 |
| 分页 | Module 3 "暂不支持" | 从 Module 1 就规划 |
| 开发顺序 | 1→10 线性 | Phase 1→4 按依赖关系 |
| 交互方式 | 仅 `/trigger` | trigger + 实体 NPC 右键 |
| 管理入口 | 独立 `admin/menu` | 扩展现有 `admin_panel` |

---

# Success Criteria

完成后应满足：

- ✅ 玩家通过 `/trigger rks_civil:news` 或 spawn 实体右键打开 GUI
- ✅ 可浏览公告（分页列表 + 阅读正文 + 返回）
- ✅ 可浏览报纸（分类 + 上一篇/下一篇 + 返回目录）
- ✅ 可浏览交流区（发帖 + 浏览 + 自动清理）
- ✅ 管理员通过 Book 写入 + 管理面板审核 + 发布
- ✅ 所有数据保存在 `storage rks_civil:main`
- ✅ GUI 与业务逻辑解耦（Render 层独立）
- ✅ 分页 + 导航统一，无代码复制
- ✅ reload / 重启 / 下线 数据不丢失
- ✅ 可继续扩展（新模块无需重构已有 GUI）