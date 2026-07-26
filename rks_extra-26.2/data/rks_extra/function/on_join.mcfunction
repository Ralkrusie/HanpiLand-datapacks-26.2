# === 玩家上线处理 ===
# 仅在玩家首次上线或重新上线时由 tick.mcfunction 调用

# 非管理员不处理
execute unless entity @s[tag=player] run return 0

# 检查是否有积压的嫌疑人记录（通过计数器判断，含离线玩家）
execute unless score #suspicious s_sus_op matches 1.. unless score #suspicious s_sus_exp matches 1.. run return 0

# 有嫌疑人记录 → 向刚上线的管理员报告
tellraw @s [{text:"",color:gray}]
tellraw @s [{text:"[rks_extra] ⚠️ 有嫌疑人记录：",color:gold,bold:true}]
execute if score #suspicious s_sus_op matches 1.. run tellraw @s [{text:"  OP泄露: ",color:red},{text:"[点击查看]",color:aqua,click_event:{action:suggest_command,command:"/function rks_extra:sus_list_op"}}]
execute if score #suspicious s_sus_exp matches 1.. run tellraw @s [{text:"  爆炸物: ",color:red},{text:"[点击查看]",color:aqua,click_event:{action:suggest_command,command:"/function rks_extra:sus_list_exp"}}]
tellraw @s [{text:"",color:gray},{text:"[清除所有记录]",color:dark_red,click_event:{action:suggest_command,command:"/function rks_extra:suspicious_clear"}}]
