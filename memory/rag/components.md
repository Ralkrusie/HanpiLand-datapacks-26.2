# 组件格式参考 (26.2+)

> 文本组件: https://minecraft.wiki/w/Raw_JSON_text_format
> 物品组件: https://minecraft.wiki/w/Item_components
> 实体数据: https://minecraft.wiki/w/Entity_format
> 方块数据: https://minecraft.wiki/w/Block_format
> NBT 格式: https://minecraft.wiki/w/NBT_format

---

## 文本组件 (JSON Text / Tellraw / Dialog)

- 完整参考: https://minecraft.wiki/w/Raw_JSON_text_format
- 可用字段:
  - `text`, `translate`, `keybind`
  - `color`, `font`
  - `bold`, `italic`, `underlined`, `strikethrough`, `obfuscated`
  - `clickEvent` (open_url, run_command, suggest_command, copy_to_clipboard)
  - `hoverEvent` (show_text, show_item, show_entity)
  - `extra` (子组件数组)
  - `insertion`

### 颜色名称 (非格式化代码)
https://minecraft.wiki/w/Raw_JSON_text_format#Color
- `black`, `dark_blue`, `dark_green`, `dark_aqua`, `dark_red`, `dark_purple`, `gold`
- `gray`, `dark_gray`, `blue`, `green`, `aqua`, `red`, `light_purple`, `yellow`, `white`
- 自定义颜色: `#RRGGBB` (1.16+)

---

## 物品组件 (Item Components)

- 完整参考: https://minecraft.wiki/w/Item_components
- 数据组件 (Data Components): https://minecraft.wiki/w/Data_component_format
- 常用组件:
  - `minecraft:custom_name` — 物品名称
  - `minecraft:lore` — 物品描述
  - `minecraft:enchantments` — 附魔
  - `minecraft:enchantment_glint_override` — 附魔光效
  - `minecraft:attribute_modifiers` — 属性修改
  - `minecraft:custom_model_data` — 自定义模型数据
  - `minecraft:damage` / `minecraft:max_damage` — 耐久
  - `minecraft:unbreakable` — 不可破坏
  - `minecraft:food` — 食物属性
  - `minecraft:consumable` — 可消耗
  - `minecraft:use_cooldown` — 使用冷却
  - `minecraft:use_remainder` — 使用后剩余
  - `minecraft:container` — 容器内容 (如潜影盒)
  - `minecraft:bundle_contents` — 收纳袋内容
  - `minecraft:can_place_on` / `minecraft:can_break` — 冒险模式限制
  - `minecraft:rarity` — 稀有度
  - `minecraft:tool` — 工具属性
  - `minecraft:jukebox_playable` — 唱片
  - `minecraft:item_model` — 物品模型 (1.21.4+)
  - `minecraft:equippable` — 可装备

---

## 实体数据 (Entity Data / NBT)

- 实体格式: https://minecraft.wiki/w/Entity_format
- 实体类型列表: https://minecraft.wiki/w/Entity#Types
- 常用字段:
  - `id`, `Pos`, `Rotation`, `Motion`
  - `Health`, `AbsorptionAmount`
  - `HandItems`, `ArmorItems`
  - `Tags` (实体标签列表)
  - `CustomName` (JSON 文本)
  - `Silent`, `NoGravity`, `Invulnerable`, `PersistenceRequired`
  - `Fire`, `Air`, `OnGround`
  - `Passengers` (骑乘)
  - `Attributes`

---

## 谓词 (Predicates / 战利品表条件)

- 完整参考: https://minecraft.wiki/w/Predicate
- 见 `predicates.md`

---

## 物品修饰器 (Item Modifiers)

- 完整参考: https://minecraft.wiki/w/Item_modifier

---

> **使用方式**: 遇到不确定的组件格式时，使用 `fetch_webpage` 工具查阅对应链接。
