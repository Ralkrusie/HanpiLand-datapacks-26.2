# ============================================
# rks_civil - 区域检测迭代入口
# 初始化索引并启动宏递归遍历所有区域
# ============================================

# 初始化：假设不在任何区域
scoreboard players set #this_area rks_civil_area_id -1

# 初始化索引并启动递归
scoreboard players set #area_idx rks_civil_timer 0
execute store result storage rks_civil:main _idx.i int 1 run scoreboard players get #area_idx rks_civil_timer
function rks_civil:area/iterate_step with storage rks_civil:main _idx
