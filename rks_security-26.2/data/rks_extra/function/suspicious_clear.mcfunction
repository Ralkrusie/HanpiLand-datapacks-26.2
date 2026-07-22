# === 清除所有嫌疑人记录 ===
# 用法: /function rks_extra:suspicious_clear

# 清除所有玩家（含离线）的嫌疑人标记（reset 而非 set 0，避免侧边栏残留）
scoreboard players reset * s_sus_op
scoreboard players reset * s_sus_exp

# 重置计数器（reset * 会清掉 #suspicious，需恢复）
scoreboard players set #suspicious s_sus_op 0
scoreboard players set #suspicious s_sus_exp 0

tellraw @s [{text:"✅ 已清除所有嫌疑人记录",color:green}]
