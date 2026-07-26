# ============================================
# rks_civil - 区域检测核心逻辑
# 遍历 storage 中所有区域，判断当前玩家 (@s) 所在区域
# 对比上次区域编号，变化时触发离开/进入
# ============================================

# 遍历所有区域，将命中的区域编号写入 #this_area
function rks_civil:area/iterate

# 如果区域未变化，直接返回（性能优化）
execute if score #this_area rks_civil_area_id = @s rks_civil_area_id run return 0

# --- 区域已变化，处理离开/进入 ---

# 离开旧区域（仅当之前确实在某个区域内时）
execute unless score @s rks_civil_area_id matches -1 run function rks_civil:area/leave

# 进入新区域（仅当本次检测到了某个区域时）
execute unless score #this_area rks_civil_area_id matches -1 run function rks_civil:area/enter

# 更新玩家当前区域记录
scoreboard players operation @s rks_civil_area_id = #this_area rks_civil_area_id
