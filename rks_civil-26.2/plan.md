# rks_civil 数据包 - 功能规划

## 概述
面向特定服务器的信息显示与交互增强数据包。核心功能：区域进入提示、公告/新闻系统。

---

## 一、区域进入提示系统

### 需求
玩家进入某个区域时，屏幕中央显示区域名称（如"雪豹小镇"），持续几秒后淡出。

### 技术方案

**整体流程：** tick循环检测 → 比对玩家上次所在区域 → 变化时触发title显示

#### 1.1 区域数据存储 (storage)
```
storage rks_civil:areas [
  {
    id: "snow_leopard_town",
    name: "雪豹小镇",
    subtitle: "北境雪原上的明珠",
    dimension: "minecraft:overworld",
    x1: -100, z1: 200,
    x2: 100, z2: 400,
    y_min: -64, y_max: 320,
    color: "gold",
    priority: 1
  },
  {
    id: "harbor_district",
    name: "港口区",
    subtitle: "咸咸的海风扑面而来",
    dimension: "minecraft:overworld",
    x1: 300, z1: -150,
    x2: 500, z2: 50,
    y_min: 50, y_max: 120,
    color: "aqua",
    priority: 1
  }
]
```

#### 1.2 检测机制
- **检测频率：** 每 10 tick（0.5秒）检测一次，兼顾性能与响应速度
- **坐标判定：** `execute if entity @s[x=...,y=...,z=...,dx=...,dy=...,dz=...]` 精确矩形区域判定
- **维度过滤：** 先检查玩家维度，仅在匹配维度时做坐标判定
- **优先级：** 当玩家同时处于多个区域（嵌套区域）时，显示 priority 最高的

#### 1.3 去重机制
- scoreboard `rks_civil_area` (dummy) 记录玩家当前所在区域的 id 哈希值
- 仅在哈希值变化时触发 enter/leave 逻辑
- 避免每 tick 重复刷屏

#### 1.4 Title 显示
```
title @s title {"text":"雪豹小镇","color":"gold","bold":true}
title @s subtitle {"text":"北境雪原上的明珠","color":"gray","italic":true}
title @s times 10 60 20   # 淡入10tick 停留60tick(3秒) 淡出20tick
```

#### 1.5 函数结构
| 函数路径 | 用途 |
|---------|------|
| `rks_civil:load` | 初始化 scoreboard、加载默认区域数据 |
| `rks_civil:tick` | 主循环入口，调度区域检测 |
| `rks_civil:area/check` | 遍历所有区域，检测单个玩家位置 |
| `rks_civil:area/enter` | 进入区域 → 记录区域id、显示title |
| `rks_civil:area/leave` | 离开区域 → 清除记录（可选：显示离开提示） |
| `rks_civil:admin/area/add` | 管理员添加区域（通过宏/预设模板） |
| `rks_civil:admin/area/remove` | 管理员按id删除区域 |
| `rks_civil:admin/area/list` | 列出所有已定义区域 |

#### 1.6 备选：标记实体方案
如果不想用坐标硬编码，也可以用隐形 armor_stand 作为区域标记：
- 在区域中心放置带 tag 的 marker entity
- 用 `distance=..50` 做球形范围检测
- 优点：可视化、不需要记坐标
- 缺点：球体而非矩形，精度不如坐标判定

---

## 二、公告/新闻系统

### 需求
管理员可编写公告、新闻；玩家可随时方便地查看。

### 技术方案

#### 2.1 数据存储 (storage)
```
storage rks_civil:news [
  {
    id: 1,
    title: "服务器周更新公告",
    content: [
      "1. 港口区新增钓鱼商店",
      "2. 雪豹小镇道路翻新完成",
      "3. 修复了xxx的bug"
    ],
    author: "Beluga",
    timestamp: "2026-07-24",
    expire: "2026-08-24",       # 可选：过期时间，到期自动隐藏
    type: "announcement",       # announcement / news / event / guide
    pinned: true                # 置顶
  }
]
```

#### 2.2 玩家查看方式
**推荐方案：tellraw 分页翻页系统**
- 玩家输入 `/trigger rks_civil:news` 触发查看
- 在聊天栏用 tellraw 输出新闻列表，每页5条
- 底部显示 `[上一页] [下一页] [关闭]` 可点击按钮
- 点击标题可展开查看完整内容

**翻页实现：**
- scoreboard `rks_civil_news_page` 记录每个玩家的当前页码
- 点击按钮执行 `/trigger rks_civil:news_page` 改变页码
- 用 storage 宏动态生成对应页的 tellraw

#### 2.3 管理员操作
| 函数路径 | 用途 |
|---------|------|
| `rks_civil:admin/news/add` | 添加新闻（通过预设模板复制到 storage） |
| `rks_civil:admin/news/remove` | 按id删除指定新闻 |
| `rks_civil:admin/news/pin` | 置顶/取消置顶 |
| `rks_civil:admin/news/broadcast` | 广播某条新闻给全服（title + chat） |
| `rks_civil:admin/news/clear_expired` | 清理过期新闻 |

#### 2.4 新玩家通知
- join 函数中检查是否有未读公告
- 如果有 pin 或最近3天的新闻，用 tellraw 提示玩家：`点击这里查看最新公告`
- 用 scoreboard `rks_civil_news_read` 记录玩家已读的最新新闻id

---

## 三、附加增强功能（建议）

### 3.1 进服欢迎消息 (MOTD)
- storage 存储可编辑的欢迎消息
- 玩家进服时 tellraw 展示（含可点击链接）
- 比直接写在 join.mcfunction 里灵活，管理员可随时改

### 3.2 常用地点速查
- `/trigger rks_civil:locations` 显示服务器重要坐标
- 预设：出生点、商店区、活动区、矿区等
- tellraw 点击坐标可自动填充到聊天栏

### 3.3 在线信息查询
- `/trigger rks_civil:info` 显示服务器基本信息
- 在线人数、当前时间（游戏内）、已加载数据包版本等

### 3.4 自定义称号系统（进阶）
- 结合区域系统，玩家在特定区域获得称号前缀
- 如：在雪豹小镇 → `[雪豹镇民] 玩家名`

---

## 四、文件结构规划

```
data/
├── rks_civil/
│   ├── function/
│   │   ├── load.mcfunction           # 初始化入口（#minecraft:load 调用）
│   │   ├── tick.mcfunction           # 主循环（#minecraft:tick 调用）
│   │   ├── join.mcfunction           # 玩家进服处理
│   │   ├── area/
│   │   │   ├── check.mcfunction      # 区域检测主逻辑
│   │   │   ├── enter.mcfunction      # 进入区域处理
│   │   │   └── leave.mcfunction      # 离开区域处理
│   │   ├── news/
│   │   │   ├── view.mcfunction       # 玩家查看新闻列表
│   │   │   ├── page_next.mcfunction  # 下一页
│   │   │   ├── page_prev.mcfunction  # 上一页
│   │   │   └── detail.mcfunction     # 查看新闻详情
│   │   └── admin/
│   │       ├── area/
│   │       │   ├── add.mcfunction
│   │       │   ├── remove.mcfunction
│   │       │   └── list.mcfunction
│   │       └── news/
│   │           ├── add.mcfunction
│   │           ├── remove.mcfunction
│   │           ├── pin.mcfunction
│   │           ├── broadcast.mcfunction
│   │           └── clear_expired.mcfunction
│   ├── advancement/                  # (预留) 相关进度
│   ├── loot_table/                   # (预留)
│   ├── recipe/                       # (预留)
│   ├── structure/                    # (预留)
│   ├── tags/
│   │   └── function/                 # (预留) 函数标签
│   └── worldgen/                     # (预留)
└── minecraft/
    └── tags/
        └── function/
            ├── load.json             # {"values":["rks_civil:load"]}
            └── tick.json             # {"values":["rks_civil:tick"]}
```

---

## 五、开发优先级

| 优先级 | 功能 | 说明 |
|-------|------|------|
| P0 | 基础框架 (load/tick/join) | 数据包骨架，必须最先完成 |
| P0 | 区域进入提示 | 核心需求 |
| P0 | 公告系统-管理员增删 | 核心需求 |
| P1 | 公告系统-玩家查看（分页） | 核心需求 |
| P1 | 公告系统-新玩家通知 | 体验优化 |
| P2 | MOTD 可编辑欢迎消息 | 锦上添花 |
| P2 | 常用地点速查 | 方便玩家 |
| P3 | 称号系统 | 进阶功能 |
