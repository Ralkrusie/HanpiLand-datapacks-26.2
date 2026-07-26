# ============================================
# rks_civil - 区域检测宏递归步骤
# 参数 $(i) = 当前区域索引（来自 _idx.i）
# 将检查委托给 iterate_check，它用 areas[$(i)] 的数据
# ============================================

# 无更多区域时停止
$execute unless data storage rks_civil:main areas[$(i)] run return 0

# 委托给 iterate_check，传入当前区域数据
$function rks_civil:area/iterate_check with storage rks_civil:main areas[$(i)]

# 索引+1 并递归
scoreboard players add #area_idx rks_civil_timer 1
execute store result storage rks_civil:main _idx.i int 1 run scoreboard players get #area_idx rks_civil_timer
function rks_civil:area/iterate_step with storage rks_civil:main _idx
