# 进度参考 (26.2+)

> 进度完整参考: https://minecraft.wiki/w/Advancement
> 原版进度列表(参考): https://minecraft.wiki/w/Advancement#List_of_advancements
> 触发器列表: https://minecraft.wiki/w/Advancement#Triggers

---

## 进度文件结构

```json
{
  "display": {
    "title": "标题",
    "description": "描述",
    "icon": {
      "id": "minecraft:diamond"
    },
    "background": "minecraft:textures/gui/advancements/backgrounds/stone.png",
    "frame": "task",
    "show_toast": true,
    "announce_to_chat": true,
    "hidden": false
  },
  "parent": "namespace:path/parent",
  "criteria": {
    "trigger_name": {
      "trigger": "minecraft:inventory_changed",
      "conditions": {
        "items": [
          {
            "items": "minecraft:diamond"
          }
        ]
      }
    }
  },
  "requirements": [
    ["trigger_name"]
  ],
  "rewards": {
    "function": "namespace:path/function",
    "loot": ["namespace:path/loot_table"],
    "experience": 100
  },
  "sends_telemetry_event": false
}
```

## 常用触发器

- `minecraft:inventory_changed` — 物品栏变化
- `minecraft:item_used_on_block` — 在方块上使用物品
- `minecraft:item_durability_changed` — 物品耐久变化
- `minecraft:player_killed_entity` — 玩家杀死实体
- `minecraft:entity_killed_player` — 实体杀死玩家
- `minecraft:player_hurt_entity` — 玩家伤害实体
- `minecraft:entity_hurt_player` — 实体伤害玩家
- `minecraft:impossible` — 仅可函数触发
- `minecraft:tick` — 每刻触发
- `minecraft:location` — 位置触发
- `minecraft:enter_block` — 进入方块
- `minecraft:effects_changed` — 状态效果变化
- `minecraft:changed_dimension` — 维度切换
- `minecraft:recipe_crafted` — 合成配方
- `minecraft:using_item` — 正在使用物品
- `minecraft:default_block_use` — 默认方块使用
- `minecraft:any_block_use` — 任意方块使用
- `minecraft:consume_item` — 消耗物品
- `minecraft:fall_after_explosion` — 爆炸后掉落

## 显示设置

- `frame`: `task` | `goal` | `challenge`
- `background`: 仅根进度需要（选项卡背景）
- `show_toast`: 是否弹出提示
- `announce_to_chat`: 是否聊天公告
- `hidden`: 是否隐藏（需完成才显示）

## requirements

- `[["a","b"]]` — a 和 b 都必须完成
- `[["a"],["b"]]` — a 或 b 任一完成即可

---

> **使用方式**: 编写进度时，查阅上方链接确认触发器条件的正确写法。
