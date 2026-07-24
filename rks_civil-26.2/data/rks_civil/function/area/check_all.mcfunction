# ============================================
# rks_civil - 区域检测调度器
# 重置计时器并对所有玩家执行区域检测
# ============================================

# 重置节流计时器
scoreboard players set #tick_timer rks_civil_timer 0

# 对所有在线玩家执行区域检测
execute as @a at @s run function rks_civil:area/check
