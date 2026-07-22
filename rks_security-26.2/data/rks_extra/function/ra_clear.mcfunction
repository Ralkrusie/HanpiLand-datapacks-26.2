# 清除周围的重生锚
fill ~-8 ~-8 ~-8 ~8 ~8 ~8 air replace minecraft:respawn_anchor

# 设置归还倒计时
scoreboard players set @s ra_return_cd 2

# 警告玩家
tellraw @s {text:"【警告】主世界不能使用重生锚！",color:red}
