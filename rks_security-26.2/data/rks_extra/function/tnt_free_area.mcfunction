# ============================================================
# 防爆区TNT清理（基于Storage动态配置，支持游戏内热编辑）
# 区域数据存储在: storage rks_extra:storage tnt_free.areas
#
# 管理员命令:
#   查看区域: /function rks_extra:tnt_free_area/list
#   添加区域: /function rks_extra:tnt_free_area/add {x:<minX>,y:<minY>,z:<minZ>,dx:<宽>,dy:<高>,dz:<深>}
#   删除区域: /function rks_extra:tnt_free_area/remove {index:<序号>}
#   清空区域: /function rks_extra:tnt_free_area/clear
#   重置默认: /function rks_extra:tnt_free_area/init
# ============================================================

# 初始化遍历索引（O(n)索引计数方式，无数组移位开销）
scoreboard players set #tnt_free_idx tnt_free_idx 0
# 递归遍历所有区域并清理TNT
function rks_extra:tnt_free_area/iterate