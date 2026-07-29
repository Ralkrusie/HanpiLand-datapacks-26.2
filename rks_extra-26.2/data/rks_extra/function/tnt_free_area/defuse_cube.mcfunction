# 解除点燃硫方怪的武装（重置导火索，阻止爆炸）
# 由 tnt_free_area/kill 宏函数调用，此时 @s 为防爆区内的 sulfur_cube
#
# 注意：不触碰 armor.body 槽位，清空会导致硫方怪进入闪烁鬼畜状态

# 将 fuse 值存入计分板（若无 fuse 标签则 get 失败，得 0）
execute store result score @s cube_fuse run data get entity @s fuse

# 仅在导火索倒计时中（fuse 在 1~119）时处理
# fuse=0（无标签/未点燃）或 fuse≥120（刚重置）均为安全状态
execute unless score @s cube_fuse matches 1..119 run return 0

# 重置导火索，阻止爆炸（每 tick 重置回 120，fuse 永远到不了 0）
data modify entity @s fuse set value 120
