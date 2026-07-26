# ============================================
# rks_civil - 区域列表显示（宏）
# 参数: $(idx), $(name), $(color), $(x), $(y), $(z), $(ex), $(ey), $(ez), $(dimension)
# ============================================

$tellraw @s [{text:"[$(idx)] ",color:"gold"},{text:"「$(name)」 ",color:"$(color)"},{text:"($(x),$(y),$(z)) → ($(ex),$(ey),$(ez)) ",color:"white"},{text:"[$(dimension)]",color:"gray"}]
