# ============================================
# rks_civil - 添加区域（宏）
# 用法: /function rks_civil:area/add {x:,y:,z:,dx:,dy:,dz:,name:"<名称>",subtitle:"<副标题>",color:"<颜色>",dimension:"<维度>"}
# 注: id 已移除，系统使用数组索引自动标识区域
# ============================================

# 若存储未初始化则先创建空数组
execute unless data storage rks_civil:main areas run data modify storage rks_civil:main areas set value []

# 暂存区域数据，以便处理默认颜色
$data modify storage rks_civil:main _tmp.new_area set value {name:"$(name)",subtitle:"$(subtitle)",color:"$(color)",x:$(x),y:$(y),z:$(z),dx:$(dx),dy:$(dy),dz:$(dz),dimension:"$(dimension)"}

# 若 color 为空则默认使用 white
execute if data storage rks_civil:main {_tmp:{new_area:{color:""}}} run data modify storage rks_civil:main _tmp.new_area.color set value "white"

# 添加到数组并清理
data modify storage rks_civil:main areas append from storage rks_civil:main _tmp.new_area
data remove storage rks_civil:main _tmp.new_area

$tellraw @s {text:"✅ 已添加区域「$(name)」: 起点($(x),$(y),$(z)) 范围[$(dx)×$(dy)×$(dz)]",color:"green"}