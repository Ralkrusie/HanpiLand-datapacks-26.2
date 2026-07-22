# 宏函数：按序号移除一个防爆区
# 用法: /function rks_extra:tnt_free_area/remove {index:<序号>}
# 序号从0开始，先用 list 查看各区域的序号
$data remove storage rks_extra:storage tnt_free.areas[$(index)]
$tellraw @s {text:"🗑️ 已移除序号 $(index) 的防爆区",color:gold}
