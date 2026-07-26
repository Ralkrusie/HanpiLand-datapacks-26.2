# ============================================
# rks_civil - 区域列表宏递归步骤
# 参数 $(i) = 当前索引
# ============================================

$execute unless data storage rks_civil:main areas[$(i)] run return 0

# 1. 提取起点和跨度到计分板
$execute store result score #_cx rks_civil_timer run data get storage rks_civil:main areas[$(i)].x
$execute store result score #_cy rks_civil_timer run data get storage rks_civil:main areas[$(i)].y
$execute store result score #_cz rks_civil_timer run data get storage rks_civil:main areas[$(i)].z
$execute store result score #_cdx rks_civil_timer run data get storage rks_civil:main areas[$(i)].dx
$execute store result score #_cdy rks_civil_timer run data get storage rks_civil:main areas[$(i)].dy
$execute store result score #_cdz rks_civil_timer run data get storage rks_civil:main areas[$(i)].dz

# 2. 计分板加法：终点 = 起点 + 跨度
scoreboard players operation #_cx rks_civil_timer += #_cdx rks_civil_timer
scoreboard players operation #_cy rks_civil_timer += #_cdy rks_civil_timer
scoreboard players operation #_cz rks_civil_timer += #_cdz rks_civil_timer

# 3. 终点存回 storage
execute store result storage rks_civil:main _show.ex int 1 run scoreboard players get #_cx rks_civil_timer
execute store result storage rks_civil:main _show.ey int 1 run scoreboard players get #_cy rks_civil_timer
execute store result storage rks_civil:main _show.ez int 1 run scoreboard players get #_cz rks_civil_timer

# 4. 合并索引和区域数据
$data modify storage rks_civil:main _show.idx set value $(i)
$data modify storage rks_civil:main _show merge from storage rks_civil:main areas[$(i)]
function rks_civil:area/list_show with storage rks_civil:main _show

# 索引+1 并递归
scoreboard players add #list_idx rks_civil_timer 1
execute store result storage rks_civil:main _idx.i int 1 run scoreboard players get #list_idx rks_civil_timer
function rks_civil:area/list_step with storage rks_civil:main _idx
