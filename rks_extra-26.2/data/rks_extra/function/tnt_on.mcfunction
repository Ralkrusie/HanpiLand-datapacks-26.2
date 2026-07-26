fill ~-8 ~-8 ~-8 ~8 ~8 ~8 air replace minecraft:tnt

scoreboard players set @s tnt_return_cd 2

tellraw @s {text:"【警告】服务器每分钟只能放置1个TNT",color:red}

scoreboard players set @s tnt_count 1

scoreboard players set @s tnt_restrained 1


