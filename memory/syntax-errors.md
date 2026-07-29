# 语法错误记录

## 26.2: 实体谓词必须使用命名空间前缀

**错误信息**: `Cannot find entity_sub_predicate_type "minecraft:type"` (undeclaredSymbol)

**原因**: 在 26.2 (1.21+) 中，loot table / predicate 中的实体谓词（entity predicate）字段必须使用带 `minecraft:` 前缀的命名空间键，不能再使用旧版简写。

**影响范围**: `entity_properties` condition 的 `predicate` 对象中的所有子字段。

| 旧格式 ❌ | 新格式 ✅ |
|---|---|
| `"flags": {...}` | `"minecraft:flags": {...}` |
| `"vehicle": {"type": "..."}` | `"minecraft:vehicle": {"minecraft:entity_type": "..."}` |
| `"equipment": {...}` | `"minecraft:equipment": {...}` |
| `"type": "..."` | `"minecraft:type_specific": {...}` 或 `"minecraft:entity_type": "..."` |

**注意**: `vehicle` 内部不再使用简写 `"type"`，而是完整写成 `"minecraft:entity_type"`。

> **格式**: 每条错误记录包含：版本、错误写法、正确写法、教训。
> **目的**: 避免智能体在后续对话中重复犯同样的语法错误。

---

## 模板

```markdown
### ❌ 错误标题 (版本: 26.x)
- **错误**: 
- **正确**: 
- **发现日期**: YYYY-MM-DD
- **来源上下文**: 
- **教训**: 
```

---

## 错误记录

<!-- 在此下方按版本分组添加错误记录 -->

### 26.2 版本

<!-- 示例条目（使用时取消注释）:
### ❌ 示例错误 (版本: 26.2)
- **错误**: `/execute as @a run say hi`
- **正确**: （如语法正确则写"语法正确，逻辑错误"）
- **发现日期**: 2026-07-26
- **来源上下文**: 在编写 xxx 功能时
- **教训**: xxx
-->

---
