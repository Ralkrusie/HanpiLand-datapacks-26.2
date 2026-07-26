tellraw @a {text:"已加载rks_extra数据包for 26.2+, v2.1",color:"yellow"}
scoreboard objectives add s_joined dummy
scoreboard objectives add good dummy
scoreboard objectives add loop dummy

scoreboard objectives add tnt_used minecraft.used:minecraft.tnt
scoreboard objectives add tnt_prev dummy
scoreboard objectives add tnt_count dummy
scoreboard objectives add tnt_timer dummy
scoreboard objectives add tnt_restrained dummy
scoreboard objectives add tnt_return_cd dummy
scoreboard objectives add explosive_suspicious dummy
scoreboard objectives add tnt_free_idx dummy
scoreboard objectives add calc dummy

scoreboard objectives add ra_return_cd dummy

# === 服务器安全管理员面板 ===
scoreboard objectives add extra_ap_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add extra_ap_prev dummy

# === 嫌疑人持久记录系统 ===
scoreboard objectives add s_online dummy
scoreboard objectives add s_sus_op dummy
scoreboard objectives add s_sus_exp dummy
# 初始化嫌疑人计数器
scoreboard players set #suspicious s_sus_op 0
scoreboard players set #suspicious s_sus_exp 0

scoreboard players set #Global tnt_timer 0

# 初始化防爆区存储（首次加载时写入默认区域，后续保留游戏内编辑结果）
function rks_extra:tnt_free_area/init

