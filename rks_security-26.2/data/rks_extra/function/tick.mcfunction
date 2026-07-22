# === 玩家上线检测（必须放在最前面）===
execute as @a unless score @s s_online matches 1 run function rks_extra:on_join

# 由于通报的循环时间
scoreboard players add #Global loop 1

# 记录加入服务器的玩家
execute as @a unless score @s s_joined matches 1 run scoreboard players set @s tnt_prev 0
execute as @a unless score @s s_joined matches 1 run scoreboard players set @s tnt_count 0
execute as @a unless score @s s_joined matches 1 run scoreboard players set @s s_joined 1


#一.OP泄露检测
function rks_extra:detect

# === OP泄露嫌疑人持久记录（首次标记时写入）===
execute as @a[scores={good=1}] unless score @s s_sus_op matches 1 run scoreboard players add #suspicious s_sus_op 1
execute as @a[scores={good=1}] unless score @s s_sus_op matches 1 run scoreboard players set @s s_sus_op 1

execute as @a if score #Global loop matches 200.. run scoreboard players set #Global loop 0

execute if score #Global loop matches 100 if entity @a[scores={good=1}] run tellraw @a[tag=player] [{text:"[op泄露警报] \n",color:red,bold:true},{text:"嫌疑玩家: ",color:gray},{selector:"@a[scores={good=1}]",color:yellow,separator:{text:", ",color:gray}}]





# 二. 爆炸检测
# 1.防爆区禁止实体tnt
function rks_extra:tnt_free_area

# 2. 给可疑玩家的explosive_suspicious分数加1
execute in minecraft:overworld as @e[type=minecraft:end_crystal] at @a[distance=..8] run execute unless entity @s[tag=explosive_trusted] run scoreboard players add @s explosive_suspicious 1
execute in minecraft:overworld as @e[type=minecraft:tnt_minecart] at @a[distance=..8] run execute unless entity @s[tag=explosive_trusted] run scoreboard players add @s explosive_suspicious 1

# 3. 向所有管理员发送警报
execute if score #Global loop matches 100 if entity @a[scores={explosive_suspicious=1}] run tellraw @a[tag=player] [{text:"[防爆警报] ",color:red,bold:true},{text:"有人试图在主世界放置末影水晶/TNT矿车！\n",color:gold},{text:"嫌疑玩家: ",color:gray},{selector:"@a[scores={explosive_suspicious=1}]",color:yellow}]

# 4. 彻底销毁这些水晶和TNT矿车
execute as @e[type=minecraft:end_crystal] at @s if dimension minecraft:overworld run kill @s
execute as @e[type=minecraft:tnt_minecart] at @s if dimension minecraft:overworld run kill @s

# === 爆炸嫌疑人持久记录（首次标记时写入）===
execute as @a[scores={explosive_suspicious=1..}] unless score @s s_sus_exp matches 1 run scoreboard players add #suspicious s_sus_exp 1
execute as @a[scores={explosive_suspicious=1..}] unless score @s s_sus_exp matches 1 run scoreboard players set @s s_sus_exp 1






# 三. TNT使用检测
execute as @a if score @s tnt_used > @s tnt_prev run function rks_extra:tnt_trigger

execute as @a[scores={tnt_count=2..}] at @s run function rks_extra:tnt_on
execute as @a[scores={tnt_return_cd=1..}] run scoreboard players remove @s tnt_return_cd 1
execute as @a[scores={tnt_return_cd=0}] run function rks_extra:tnt_return

scoreboard players add #Global tnt_timer 1
execute if score #Global tnt_timer matches 1200 run function rks_extra:tnt_off


# 四. 重生锚归还倒计时
execute as @a[scores={ra_return_cd=1..}] run scoreboard players remove @s ra_return_cd 1
execute as @a[scores={ra_return_cd=0}] run function rks_extra:ra_return

# === 更新在线状态（最后执行，用于下一tick的上线检测）===
scoreboard players set * s_online 0
scoreboard players set @a s_online 1
