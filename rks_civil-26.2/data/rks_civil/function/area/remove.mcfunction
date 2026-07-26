# ============================================
# rks_civil - 删除区域（宏）
# 用法: /function rks_civil:area/remove {index:<序号>}
# ============================================

$data remove storage rks_civil:main areas[$(index)]
$tellraw @s {text:"🗑️ 已移除序号 $(index) 的区域",color:"gold"}
