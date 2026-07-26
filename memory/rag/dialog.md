# Dialog GUI 参考 (26.2+)

> Dialog 命令: https://minecraft.wiki/w/Commands/dialog
> Dialog JSON 格式: https://minecraft.wiki/w/Dialog

---

## 命令语法

```
dialog <targets> <action> ...
```

### 子命令
- `dialog <targets> open <namespace:path>` — 打开 dialog
- `dialog <targets> close` — 关闭 dialog

---

## Dialog JSON 结构 (推测/速查)

> ⚠️ Dialog 系统在 26.2 可能仍处于实验阶段，以 Wiki 最新版为准。

```json
{
  "type": "minecraft:dialog",
  "title": {"text": "标题"},
  "body": [
    {"text": "第一行"},
    {"text": "第二行"}
  ],
  "buttons": [
    {
      "text": {"text": "按钮1"},
      "action": {
        "type": "minecraft:run_function",
        "function": "namespace:path/function"
      }
    },
    {
      "text": {"text": "关闭"},
      "action": {
        "type": "minecraft:close"
      }
    }
  ]
}
```

---

## 与 tellraw / book 的对比

| 特性 | Dialog | Tellraw | Book |
|------|--------|---------|------|
| 多按钮 | ✅ | ❌ (仅 clickEvent) | ❌ |
| 多页 | ✅ (分页) | ❌ | ✅ |
| 格式化文本 | ✅ | ✅ | ✅ |
| 免聊天栏 | ✅ | ❌ | ✅ |
| 动态内容 | ✅ | ❌ | ❌ |
| 关闭检测 | ✅ | ❌ | ❌ |

---

> **使用方式**: Dialog 是较新的系统，语法可能不稳定。编写前务必查阅最新 Wiki。
