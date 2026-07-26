# ============================================
# rks_civil - 区域检测判定（宏）
# 参数来自 areas[$(i)]: $(dimension), $(x), $(y), $(z), $(dx), $(dy), $(dz)
# #area_idx 中保存当前索引，命中时写入 #this_area
# ============================================

$execute if dimension $(dimension) positioned $(x) $(y) $(z) if entity @s[dx=$(dx),dy=$(dy),dz=$(dz)] run scoreboard players operation #this_area rks_civil_area_id = #area_idx rks_civil_timer
