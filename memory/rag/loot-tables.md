# 战利品表参考 (26.2+)

> 战利品表完整参考: https://minecraft.wiki/w/Loot_table
> 谓词 (Conditions): https://minecraft.wiki/w/Predicate
> 物品修饰器 (Functions): https://minecraft.wiki/w/Item_modifier
> 随机序列: https://minecraft.wiki/w/Random_sequence

---

## 战利品表结构

```json
{
  "type": "minecraft:block",  // 或: entity, chest, fishing, gift, etc.
  "pools": [
    {
      "rolls": 1,
      "bonus_rolls": 0,
      "conditions": [],
      "functions": [],
      "entries": [
        {
          "type": "minecraft:item",  // 或: tag, loot_table, dynamic, empty, alternatives, sequence, group
          "name": "minecraft:diamond",
          "functions": [],
          "conditions": [],
          "weight": 1
        }
      ]
    }
  ]
}
```

## 常用条目类型 (Entry Types)

- `minecraft:item` — 单个物品
- `minecraft:tag` — 物品标签
- `minecraft:loot_table` — 引用其他战利品表
- `minecraft:dynamic` — 动态（如方块实体内容）
- `minecraft:empty` — 无掉落
- `minecraft:alternatives` — 首个满足条件的子条目
- `minecraft:sequence` — 依次执行子条目
- `minecraft:group` — 子条目组

## 常用条件 (Predicates / Conditions)

完整列表: https://minecraft.wiki/w/Predicate

- `minecraft:random_chance` — 随机概率
- `minecraft:random_chance_with_enchanted` — 受附魔影响的概率
- `minecraft:match_tool` — 匹配工具
- `minecraft:survives_explosion` — 爆炸幸存
- `minecraft:entity_properties` — 实体属性
- `minecraft:location_check` — 位置检查
- `minecraft:weather_check` — 天气检查
- `minecraft:time_check` — 时间检查
- `minecraft:value_check` — 数值检查
- `minecraft:inverted` — 取反
- `minecraft:any_of` / `minecraft:all_of` — 或 / 且

## 常用物品修饰器 (Item Modifiers / Functions)

完整列表: https://minecraft.wiki/w/Item_modifier

- `minecraft:set_count` — 设置数量
- `minecraft:set_damage` — 设置耐久
- `minecraft:set_name` — 设置名称
- `minecraft:set_lore` — 设置描述
- `minecraft:set_enchantments` — 设置附魔
- `minecraft:enchant_with_levels` — 随机附魔
- `minecraft:set_nbt` — 设置 NBT
- `minecraft:set_custom_model_data` — 设置 CMD
- `minecraft:set_attributes` — 设置属性
- `minecraft:set_components` — 设置数据组件 (1.21+)
- `minecraft:copy_components` — 复制数据组件 (1.21+)
- `minecraft:copy_name` — 复制名称
- `minecraft:copy_state` — 复制方块状态
- `minecraft:explosion_decay` — 爆炸衰减
- `minecraft:furnace_smelt` — 熔炉烧炼
- `minecraft:limit_count` — 限制数量上限

---

## 战利品表注入 (Loot Table Injection)

- 覆盖原版战利品表: `data/minecraft/loot_table/<type>/<name>.json`
- 自定义战利品表: `data/<namespace>/loot_table/<path>.json`

---

> **使用方式**: 编写或修改战利品表时，查阅上方对应链接。
