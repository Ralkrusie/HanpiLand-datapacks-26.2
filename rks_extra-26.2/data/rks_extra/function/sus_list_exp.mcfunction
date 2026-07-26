# === 查看爆炸嫌疑人（含离线） ===
# 用法: /function rks_extra:sus_list_exp

tellraw @s [{text:"▸ 爆炸嫌疑人 → 请看屏幕右侧侧边栏（5秒后自动恢复）",color:gold}]

scoreboard objectives setdisplay sidebar s_sus_exp
schedule function rks_extra:sus_sidebar_clear 5s
