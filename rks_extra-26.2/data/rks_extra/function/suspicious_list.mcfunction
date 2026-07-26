# === 查看嫌疑人记录 ===
# 用法: /function rks_extra:suspicious_list

tellraw @s [{text:"",color:gray}]
tellraw @s [{text:"=== 嫌疑人记录 ===",color:gold,bold:true}]
tellraw @s [{text:"",color:gray}]
tellraw @s [{text:"  [查看OP泄露嫌疑人]  ",color:red,click_event:{action:suggest_command,command:"/function rks_extra:sus_list_op"}}]
tellraw @s [{text:"  [查看爆炸嫌疑人]  ",color:red,click_event:{action:suggest_command,command:"/function rks_extra:sus_list_exp"}}]
tellraw @s [{text:"",color:gray}]
tellraw @s [{text:"  [清除所有记录]  ",color:dark_red,click_event:{action:suggest_command,command:"/function rks_extra:suspicious_clear"}}]