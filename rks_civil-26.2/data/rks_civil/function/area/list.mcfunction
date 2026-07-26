# ============================================
# rks_civil - 列出所有区域（宏递归）
# ============================================

tellraw @s [{text:"=== 当前区域列表 ===",color:"gold",bold:true}]
tellraw @s [{text:"（序号从0开始）",color:"gray"}]

# 初始化索引并启动递归
scoreboard players set #list_idx rks_civil_timer 0
execute store result storage rks_civil:main _idx.i int 1 run scoreboard players get #list_idx rks_civil_timer
function rks_civil:area/list_step with storage rks_civil:main _idx
