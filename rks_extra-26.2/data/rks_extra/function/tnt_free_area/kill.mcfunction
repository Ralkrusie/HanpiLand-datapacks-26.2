# 宏函数：清理单个防爆区内的TNT
# 参数从 storage 列表元素中获取: x, y, z, dx, dy, dz
$execute in minecraft:overworld run kill @e[type=minecraft:tnt,x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)]
