# 将当前记分板索引（0）导出到storage，供宏使用
# scoreboard → storage tnt_free.idx.i
execute store result storage rks_extra:storage tnt_free.idx.i int 1 run scoreboard players get #tnt_free_idx tnt_free_idx
# 启动递归遍历（索引递增和递归由 iterate_step 自行处理）
function rks_extra:tnt_free_area/iterate_step with storage rks_extra:storage tnt_free.idx
