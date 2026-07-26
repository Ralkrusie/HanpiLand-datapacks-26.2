# 宏函数：遍历并显示每个防爆区（计算终点坐标）
# 参数 $(i) = 当前索引
$execute unless data storage rks_extra:storage tnt_free.areas[$(i)] run return 0
# 1. 从 storage 提取坐标到计分板
$execute store result score #_cx calc run data get storage rks_extra:storage tnt_free.areas[$(i)].x
$execute store result score #_cy calc run data get storage rks_extra:storage tnt_free.areas[$(i)].y
$execute store result score #_cz calc run data get storage rks_extra:storage tnt_free.areas[$(i)].z
$execute store result score #_cdx calc run data get storage rks_extra:storage tnt_free.areas[$(i)].dx
$execute store result score #_cdy calc run data get storage rks_extra:storage tnt_free.areas[$(i)].dy
$execute store result score #_cdz calc run data get storage rks_extra:storage tnt_free.areas[$(i)].dz
# 2. 计分板加法：终点 = 起点 + 跨度
scoreboard players operation #_cx calc += #_cdx calc
scoreboard players operation #_cy calc += #_cdy calc
scoreboard players operation #_cz calc += #_cdz calc
# 3. 终点坐标存回 storage
execute store result storage rks_extra:storage tnt_free._show.ex int 1 run scoreboard players get #_cx calc
execute store result storage rks_extra:storage tnt_free._show.ey int 1 run scoreboard players get #_cy calc
execute store result storage rks_extra:storage tnt_free._show.ez int 1 run scoreboard players get #_cz calc
# 4. 合并序号和原始区域数据到 _show
$data modify storage rks_extra:storage tnt_free._show.idx set value $(i)
$data modify storage rks_extra:storage tnt_free._show merge from storage rks_extra:storage tnt_free.areas[$(i)]
# 4.5. 兼容旧数据：如无 name 字段则设为"未命名"
execute unless data storage rks_extra:storage tnt_free._show.name run data modify storage rks_extra:storage tnt_free._show.name set value "未命名"
# 5. 展示
function rks_extra:tnt_free_area/list_show with storage rks_extra:storage tnt_free._show
# 6. 索引+1 并递归
scoreboard players add #tnt_free_idx tnt_free_idx 1
execute store result storage rks_extra:storage tnt_free.idx.i int 1 run scoreboard players get #tnt_free_idx tnt_free_idx
function rks_extra:tnt_free_area/list_step with storage rks_extra:storage tnt_free.idx
