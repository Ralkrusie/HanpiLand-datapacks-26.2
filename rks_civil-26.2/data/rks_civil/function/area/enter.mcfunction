# ============================================
# rks_civil - 进入区域提示
# 从 storage 读取当前区域数据，显示 title
# 执行上下文：@s = 触发玩家, #this_area = 区域编号
# ============================================

# 导出区域编号到 storage，先合并数据再显示
execute store result storage rks_civil:main _enter.i int 1 run scoreboard players get #this_area rks_civil_area_id
function rks_civil:area/enter_prep with storage rks_civil:main _enter
