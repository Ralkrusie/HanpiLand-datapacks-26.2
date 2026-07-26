# 谓词参考 (26.2+)

> 完整谓词列表: https://minecraft.wiki/w/Predicate
> 谓词文件格式: https://minecraft.wiki/w/Predicate#Predicate_file_format

---

## 谓词文件结构

```json
{
  "condition": "minecraft:entity_properties",
  "entity": "this",
  "predicate": {
    "type": "minecraft:player"
  }
}
```

## 可用条件列表

### 实体类
- `minecraft:entity_properties` — 实体属性检查
- `minecraft:entity_scores` — 实体记分板分数
- `minecraft:damage_source_properties` — 伤害来源属性

### 位置/环境类
- `minecraft:location_check` — 位置条件检查
- `minecraft:weather_check` — 天气检查
- `minecraft:time_check` — 时间周期检查
- `minecraft:light_level_check` — 光照等级检查

### 物品/方块类
- `minecraft:match_tool` — 匹配工具物品
- `minecraft:block_state_property` — 方块状态属性
- `minecraft:table_bonus` — 概率受附魔等级加成

### 逻辑类
- `minecraft:random_chance` — 随机概率 (0~1)
- `minecraft:random_chance_with_enchanted` — 受附魔影响的概率
- `minecraft:value_check` — 数值范围检查
- `minecraft:inverted` — 取反
- `minecraft:any_of` — OR（任一满足）
- `minecraft:all_of` — AND（全部满足）

### 特殊类
- `minecraft:survives_explosion` — 爆炸后是否存活
- `minecraft:enchantment_active_check` — 附魔是否激活 (1.21+)

---

## 常用属性查询

### 实体
- `type` — 实体类型
- `type_specific` — 类型特定属性 (如 player, fishing_hook, etc.)
- `flags` — 实体标志 (is_on_fire, is_sneaking, is_sprinting, is_swimming, is_baby)
- `equipment` — 装备 (head, chest, legs, feet, mainhand, offhand, body)
- `location` — 位置 (biome, dimension, structure, etc.)
- `nbt` — 原始 NBT 检查
- `periodic_tick` — 刻检查

### 位置
- `biome` / `biomes` — 生物群系
- `dimension` — 维度
- `structure` — 结构
- `block` — 方块属性 (blocks, fluid, light, smokey)

---

> **使用方式**: 编写谓词条件时，查阅上方对应链接。
