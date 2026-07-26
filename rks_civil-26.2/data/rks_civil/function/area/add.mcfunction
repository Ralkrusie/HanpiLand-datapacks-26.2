# ============================================
# rks_civil - 添加区域（宏）
# 用法: /function rks_civil:area/add {x:,y:,z:,dx:,dy:,dz:,name:"<名称>",subtitle:"<副标题>",color:"<颜色>",dimension:"<维度>"}
# ============================================

# 若存储未初始化则先创建空数组
execute unless data storage rks_civil:main areas run data modify storage rks_civil:main areas set value []
$data modify storage rks_civil:main areas append value {id:"$(id)",name:"$(name)",subtitle:"$(subtitle)",color:"$(color)",x:$(x),y:$(y),z:$(z),dx:$(dx),dy:$(dy),dz:$(dz),dimension:"$(dimension)"}
$tellraw @s {text:"✅ 已添加区域「$(name)」: 起点($(x),$(y),$(z)) 范围[$(dx)×$(dy)×$(dz)]",color:"green"}
