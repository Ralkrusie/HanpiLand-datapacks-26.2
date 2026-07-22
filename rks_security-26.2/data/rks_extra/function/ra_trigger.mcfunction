# 撤销进度，使其可重复触发
advancement revoke @s only rks_extra:ra_place

# 告知管理员
execute as @s run tellraw @a[tag=player] [{text:"【系统】",color:yellow,italic:false},{selector:"@s",color:yellow,italic:true},{text:" 放置了重生锚",color:gray,italic:true}]

# 仅主世界放置 → 清除并警告（at @s 确保在玩家位置清除）
execute as @s at @s if predicate rks_extra:in_overworld run function rks_extra:ra_clear
