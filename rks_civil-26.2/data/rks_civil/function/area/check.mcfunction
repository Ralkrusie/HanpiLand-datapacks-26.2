# ============================================
# rks_civil - 区域检测核心逻辑
# 判断当前玩家 (@s) 所在区域，对比上次区域
# 使用 #this_area 临时存储本次检测到的区域编号
# ============================================

# 初始化：假设不在任何区域
scoreboard players set #this_area rks_civil_area_id -1

# ==========================================
# 区域 0: 雪豹小镇 (x:-200~200, z:100~500)
# ==========================================
execute if dimension minecraft:overworld if entity @s[x=-200,y=-64,z=100,dx=400,dy=384,dz=400] run scoreboard players set #this_area rks_civil_area_id 0

# ==========================================
# 区域 1: 港口区 (x:300~600, z:-200~100, y:50~120)
# ==========================================
execute if dimension minecraft:overworld if entity @s[x=300,y=50,z=-200,dx=300,dy=70,dz=300] run scoreboard players set #this_area rks_civil_area_id 1

# ==========================================
# 在此处添加更多区域...
# ==========================================

# 如果区域未变化，直接返回（性能优化）
execute if score #this_area rks_civil_area_id = @s rks_civil_area_id run return 0

# --- 区域已变化，处理离开/进入 ---

# 离开旧区域（仅当之前确实在某个区域内时）
execute unless score @s rks_civil_area_id matches -1 run function rks_civil:area/leave

# 进入新区域（仅当本次检测到了某个区域时）
execute unless score #this_area rks_civil_area_id matches -1 run function rks_civil:area/enter

# 更新玩家当前区域记录
scoreboard players operation @s rks_civil_area_id = #this_area rks_civil_area_id
