# 清除所有防爆区
data remove storage rks_extra:storage tnt_free.areas
tellraw @s [{text:"已清除所有防爆区！",color:red},{text:"\n使用 /function rks_extra:tnt_free_area/init 可恢复默认区域",color:gray}]
