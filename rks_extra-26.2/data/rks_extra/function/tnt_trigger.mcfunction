execute as @s run tellraw @a[tag=player] [{text:"【系统】",color:yellow,italic:false},{selector:"@s",color:yellow,italic:true},{text:" 放置了TNT",color:gray,italic:true}]
execute unless entity @s[tag=explosive_trusted] run scoreboard players add @s tnt_count 1
scoreboard players operation @s tnt_prev = @s tnt_used
tellraw @s[scores={tnt_count=1}] {text:"【温馨提示】服务器每分钟只能放置1个TNT",color:yellow}