scoreboard players set #Global tnt_timer 0
tellraw @a[scores={tnt_count=1..}] {text:"【温馨提示】TNT限制已重置",color:green}
scoreboard players set @a tnt_count 0
scoreboard players set @a[scores={tnt_restrained=1..}] tnt_restrained 0