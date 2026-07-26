# ============================================
# 村民交易测试 - 在各职业旁召唤已配置的测试村民
# ============================================

# --- 盔甲匠 Lv1 (魔丸→铁块) ---
summon minecraft:villager ~1 ~ ~ {VillagerData:{profession:"minecraft:armorer",level:1,type:"plains"},CustomName:'"盔甲匠 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 盔甲匠 Lv3 (合金锭→魔丸) ---
summon minecraft:villager ~2 ~ ~ {VillagerData:{profession:"minecraft:armorer",level:3,type:"plains"},CustomName:'"盔甲匠 Lv3 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 工具匠 Lv1 (魔丸→钻石) ---
summon minecraft:villager ~3 ~ ~ {VillagerData:{profession:"minecraft:toolsmith",level:1,type:"plains"},CustomName:'"工具匠 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 工具匠 Lv2 (钻石→魔丸) ---
summon minecraft:villager ~4 ~ ~ {VillagerData:{profession:"minecraft:toolsmith",level:2,type:"plains"},CustomName:'"工具匠 Lv2 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 工具匠 Lv3 (魔丸→鞘翅) ---
summon minecraft:villager ~5 ~ ~ {VillagerData:{profession:"minecraft:toolsmith",level:3,type:"plains"},CustomName:'"工具匠 Lv3 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 武器匠 Lv3 (魔丸→合金锭) ---
summon minecraft:villager ~6 ~ ~ {VillagerData:{profession:"minecraft:weaponsmith",level:3,type:"plains"},CustomName:'"武器匠 Lv3 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 农民 Lv2 (魔丸→金胡萝卜) ---
summon minecraft:villager ~7 ~ ~ {VillagerData:{profession:"minecraft:farmer",level:2,type:"plains"},CustomName:'"农民 Lv2 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 农民 Lv3 (附魔金苹果→魔丸) ---
summon minecraft:villager ~8 ~ ~ {VillagerData:{profession:"minecraft:farmer",level:3,type:"plains"},CustomName:'"农民 Lv3 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 渔夫 Lv1 (海绵→魔丸) ---
summon minecraft:villager ~9 ~ ~ {VillagerData:{profession:"minecraft:fisherman",level:1,type:"plains"},CustomName:'"渔夫 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 渔夫 Lv2 (魔丸→湿海绵) ---
summon minecraft:villager ~10 ~ ~ {VillagerData:{profession:"minecraft:fisherman",level:2,type:"plains"},CustomName:'"渔夫 Lv2 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 屠夫 Lv1 (魔丸→熟牛肉) ---
summon minecraft:villager ~11 ~ ~ {VillagerData:{profession:"minecraft:butcher",level:1,type:"plains"},CustomName:'"屠夫 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 牧师 Lv1 (魔丸→幻翼膜) ---
summon minecraft:villager ~12 ~ ~ {VillagerData:{profession:"minecraft:cleric",level:1,type:"plains"},CustomName:'"牧师 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 图书管理员 Lv1 (taiko拆分, amount=3) ---
summon minecraft:villager ~13 ~ ~ {VillagerData:{profession:"minecraft:librarian",level:1,type:"plains"},CustomName:'"图书管理员 Lv1 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 图书管理员 Lv2 (grace↔contract, amount=3) ---
summon minecraft:villager ~14 ~ ~ {VillagerData:{profession:"minecraft:librarian",level:2,type:"plains"},CustomName:'"图书管理员 Lv2 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b}

# --- 流浪商人 (uncommon amount=4) ---
summon minecraft:wandering_trader ~15 ~ ~ {CustomName:'"流浪商人 测试"',CustomNameVisible:1b,NoAI:1b,Invulnerable:1b,Silent:1b,DespawnDelay:2147483647}

# 提示
tellraw @p [{"text":"✅ 已召唤 15 个测试村民 + 1 个流浪商人在面前！","color":"green"},{"text":"\n右键交易查看是否符合预期。","color":"gray"},{"text":"\n注意：同一等级不同村民的交易组合可能不同（随机选取）。","color":"yellow"}]
