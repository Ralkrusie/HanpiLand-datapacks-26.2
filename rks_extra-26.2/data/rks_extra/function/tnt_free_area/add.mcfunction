# 宏函数：添加一个防爆区
# 用法: /function rks_extra:tnt_free_area/add {x:<minX>,y:<minY>,z:<minZ>,dx:<宽度>,dy:<高度>,dz:<深度>,name:"<名称>"}
# 示例: /function rks_extra:tnt_free_area/add {x:-1100,y:-64,z:0,dx:700,dy:384,dz:600,name:"出生点"}
# 若存储尚未初始化，先创建空数组（防止 append 到不存在的路径）
execute unless data storage rks_extra:storage tnt_free.areas run data modify storage rks_extra:storage tnt_free.areas set value []
$data modify storage rks_extra:storage tnt_free.areas append value {x:$(x),y:$(y),z:$(z),dx:$(dx),dy:$(dy),dz:$(dz),name:"$(name)"}
$tellraw @s {text:"✅ 已添加防爆区「$(name)」: 起点($(x), $(y), $(z)) 范围[$(dx)×$(dy)×$(dz)]",color:green}
