# ============================================
# rks_civil - 每 tick 主循环
# 由 #minecraft:tick 标签调用
# ============================================

# 新玩家初始化（首次进入服务器的玩家）
execute as @a unless score @s rks_civil_joined matches 1 run function rks_civil:join

# 区域检测节流：每 20 tick（1 秒）执行一次
scoreboard players add #tick_timer rks_civil_timer 1
execute if score #tick_timer rks_civil_timer matches 20.. run function rks_civil:area/check_all

# === 管理员面板右键检测 ===
execute as @a[tag=player] if score @s civil_ap_used > @s civil_ap_prev at @s if items entity @s weapon *[custom_data~{panel:"civil"}] run function rks_civil:admin_panel/open
execute as @a[tag=player] run scoreboard players operation @s civil_ap_prev = @s civil_ap_used
