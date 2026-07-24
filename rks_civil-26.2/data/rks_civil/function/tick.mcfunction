# ============================================
# rks_civil - 每 tick 主循环
# 由 #minecraft:tick 标签调用
# ============================================

# 新玩家初始化（首次进入服务器的玩家）
execute as @a unless score @s rks_civil_joined matches 1 run function rks_civil:join

# 区域检测节流：每 10 tick（0.5 秒）执行一次
scoreboard players add #tick_timer rks_civil_timer 1
execute if score #tick_timer rks_civil_timer matches 20.. run function rks_civil:area/check_all
