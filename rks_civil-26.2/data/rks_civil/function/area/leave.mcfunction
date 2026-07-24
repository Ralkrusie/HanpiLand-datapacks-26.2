# ============================================
# rks_civil - 离开区域处理
# 执行上下文：@s 仍保留旧区域编号
# 当前不显示离开提示，如有需要可取消下方注释
# ============================================

# 可选：离开提示（actionbar 更不突兀）
# execute if score @s rks_civil_area_id matches 0 run title @s actionbar {"text":"~ 离开雪豹小镇 ~","color":"gray"}
# execute if score @s rks_civil_area_id matches 1 run title @s actionbar {"text":"~ 离开港口区 ~","color":"gray"}
