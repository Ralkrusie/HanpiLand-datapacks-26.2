# 宏函数：处理指定索引的防爆区，并自行递增索引递归
# 参数 $(i) = 当前索引
# 当 areas[$(i)] 不存在时自然停止
$execute unless data storage rks_extra:storage tnt_free.areas[$(i)] run return 0
# 清理当前区域
$function rks_extra:tnt_free_area/kill with storage rks_extra:storage tnt_free.areas[$(i)]
# 索引+1
scoreboard players add #tnt_free_idx tnt_free_idx 1
# 导出新索引导入storage并递归调用自身
execute store result storage rks_extra:storage tnt_free.idx.i int 1 run scoreboard players get #tnt_free_idx tnt_free_idx
function rks_extra:tnt_free_area/iterate_step with storage rks_extra:storage tnt_free.idx
