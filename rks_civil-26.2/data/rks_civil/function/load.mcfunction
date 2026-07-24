# ============================================
# rks_civil - 初始化加载
# 由 #minecraft:load 标签调用
# ============================================

tellraw @a [{"text":"[rks_civil] ","color":"gold"},{"text":"生活质量数据包已加载 v1.0","color":"yellow"},{"text":" 区域提示系统已就绪","color":"green"}]

# --- 创建计分板 ---
scoreboard objectives add rks_civil_area_id dummy
scoreboard objectives add rks_civil_timer dummy
scoreboard objectives add rks_civil_joined dummy

# --- 初始化当前在线玩家 ---
execute as @a run function rks_civil:join

# --- 将区域定义写入 storage（供将来动态读取） ---
data modify storage rks_civil:main areas set value []
data modify storage rks_civil:main areas append value {id:"snow_leopard_town",name:"雪豹小镇",subtitle:"北境雪原上的明珠",color:"gold",x1:-200,z1:100,x2:200,z2:500,y_min:-64,y_max:320,dimension:"minecraft:overworld"}
data modify storage rks_civil:main areas append value {id:"harbor",name:"港口区",subtitle:"咸咸的海风扑面而来",color:"aqua",x1:300,z1:-200,x2:600,z2:100,y_min:50,y_max:120,dimension:"minecraft:overworld"}