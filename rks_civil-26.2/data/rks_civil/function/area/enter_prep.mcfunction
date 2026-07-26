# ============================================
# rks_civil - 进入区域数据准备（宏）
# 先合并 storage 数据，再调用 enter_show
# ============================================

$data modify storage rks_civil:main _enter merge from storage rks_civil:main areas[$(i)]
function rks_civil:area/enter_show with storage rks_civil:main _enter
