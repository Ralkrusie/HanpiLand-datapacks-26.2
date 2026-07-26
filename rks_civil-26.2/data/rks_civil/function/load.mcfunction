# ============================================
# rks_civil - 初始化加载
# 由 #minecraft:load 标签调用
# ============================================

tellraw @a [{"text":"已加载rks_civil数据包 for 26.2+, v2.0","color":"yellow"}]

# --- 创建计分板 ---
scoreboard objectives add rks_civil_area_id dummy
scoreboard objectives add rks_civil_timer dummy
scoreboard objectives add rks_civil_joined dummy

# --- 管理员面板 ---
scoreboard objectives add civil_ap_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add civil_ap_prev dummy

# --- 初始化当前在线玩家 ---
execute as @a run function rks_civil:join

# --- 将区域定义写入 storage（格式: x,y,z,dx,dy,dz） ---
# 仅首次加载时写入，/reload 不覆盖（保留运行时编辑）
execute unless data storage rks_civil:main areas run data modify storage rks_civil:main areas set value []