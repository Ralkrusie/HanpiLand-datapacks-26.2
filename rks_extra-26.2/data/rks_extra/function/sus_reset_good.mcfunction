# 重置所有在线玩家的 OP 泄露嫌疑标记（good 分数）
scoreboard players set @a good 0
tellraw @s [{text:"✅ 已重置所有在线玩家的 OP 泄露标记",color:"green"}]
