# ============================================
# rks_civil - 进入区域标题显示（宏）
# 参数已在 enter_prep 中合并完毕: $(name), $(color), $(subtitle)
# ============================================

$title @s title {text:"$(name)",color:"$(color)",bold:true}
$title @s subtitle {text:"$(subtitle)",color:"gray",italic:true}
title @s times 10 20 15
