# 标签参考 (26.2+)

> 标签完整参考: https://minecraft.wiki/w/Tag
> 原版标签列表: https://minecraft.wiki/w/Tag#List_of_tags

---

## 标签类型

标签文件放在: `data/<namespace>/tags/<type>/<name>.json`

### 可用标签类型
- `block` — 方块标签
- `item` — 物品标签
- `entity_type` — 实体类型标签
- `fluid` — 流体标签
- `function` — 函数标签 (用于 #namespace:tag 批量调用)
- `game_event` — 游戏事件标签 (用于 sculk sensor)
- `advancement` — 进度标签
- `loot_table` — 战利品表标签
- `predicate` — 谓词标签
- `worldgen/biome` — 生物群系标签
- `worldgen/structure` — 结构标签
- `worldgen/flat_level_generator_preset` — 超平坦预设标签
- `worldgen/world_preset` — 世界预设标签
- `damage_type` — 伤害类型标签
- `cat_variant` — 猫变种标签
- `painting_variant` — 画变种标签
- `instrument` — 乐器标签
- `point_of_interest_type` — 兴趣点类型标签
- `banner_pattern` — 旗帜图案标签
- `enchantment` — 附魔标签
- `trim_material` / `trim_pattern` — 锻造装饰标签

---

## 标签文件格式

```json
{
  "replace": false,
  "values": [
    "minecraft:stone",
    "minecraft:dirt",
    "#minecraft:logs"
  ]
}
```

- `replace` — 是否替换原版同名标签 (默认 false，即追加)
- `values` — 条目列表，支持 `#` 前缀引用其他标签

---

## 常用原版标签 (参考用)

- 方块: `#minecraft:mineable/pickaxe`, `#minecraft:mineable/axe`, `#minecraft:needs_diamond_tool`
- 物品: `#minecraft:logs`, `#minecraft:planks`, `#minecraft:wool`, `#minecraft:stone_crafting_materials`
- 实体: `#minecraft:undead`, `#minecraft:arthropods`, `#minecraft:raiders`, `#minecraft:skeletons`
- 函数: `#minecraft:tick` (每刻执行), `#minecraft:load` (加载时执行)
- 伤害类型: `#minecraft:is_fire`, `#minecraft:is_fall`, `#minecraft:is_projectile`

---

## 函数标签 (重要)

- `#minecraft:tick` — 每刻执行的函数
- `#minecraft:load` — 加载/重载时执行的函数
- 自定义标签: `#<namespace>:<name>` — 批量调用函数

---

> **使用方式**: 不确定某标签是否存在或标签类型时，查阅 Wiki 确认。
