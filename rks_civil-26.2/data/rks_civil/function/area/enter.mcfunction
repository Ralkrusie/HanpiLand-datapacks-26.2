# ============================================
# rks_civil - 进入区域提示
# 根据 #this_area 的值显示对应区域的标题
# 执行上下文：@s = 触发玩家
# ============================================

# --- 区域 0: 雪豹小镇 ---
execute if score #this_area rks_civil_area_id matches 0 run title @s title {"text":"雪豹小镇","color":"gold","bold":true}
execute if score #this_area rks_civil_area_id matches 0 run title @s subtitle {"text":"北境雪原上的明珠","color":"gray","italic":true}
execute if score #this_area rks_civil_area_id matches 0 run title @s times 10 60 20

# --- 区域 1: 港口区 ---
execute if score #this_area rks_civil_area_id matches 1 run title @s title {"text":"港口区","color":"aqua","bold":true}
execute if score #this_area rks_civil_area_id matches 1 run title @s subtitle {"text":"咸咸的海风扑面而来","color":"gray","italic":true}
execute if score #this_area rks_civil_area_id matches 1 run title @s times 10 60 20

# --- 在此处添加更多区域的标题显示... ---
