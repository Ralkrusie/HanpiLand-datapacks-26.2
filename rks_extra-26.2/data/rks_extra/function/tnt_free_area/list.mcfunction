# 列出当前所有防爆区（宏递归 tellraw 逐条展示）
tellraw @s [{text:"=== 当前防爆区列表 ===",color:gold,bold:true}]
tellraw @s [{text:"（序号从0开始）",color:gray}]
# 初始化索引并启动递归
scoreboard players set #tnt_free_idx tnt_free_idx 0
execute store result storage rks_extra:storage tnt_free.idx.i int 1 run scoreboard players get #tnt_free_idx tnt_free_idx
function rks_extra:tnt_free_area/list_step with storage rks_extra:storage tnt_free.idx
