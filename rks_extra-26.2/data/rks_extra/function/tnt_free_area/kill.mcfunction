# 宏函数：清理单个防爆区内的爆炸威胁
# 参数从 storage 列表元素中获取: x, y, z, dx, dy, dz
# 1. 清理实体TNT
$execute in minecraft:overworld run kill @e[type=minecraft:tnt,x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)]
# 2. 解除点燃的硫方怪（宏只做位置过滤，NBT逻辑在 defuse_cube 中）
$execute in minecraft:overworld as @e[type=minecraft:sulfur_cube,x=$(x),y=$(y),z=$(z),dx=$(dx),dy=$(dy),dz=$(dz)] at @s run function rks_extra:tnt_free_area/defuse_cube
