execute as @a[gamemode=creative] unless entity @s[tag=player] run function rks_extra:judgement
execute as @a[gamemode=spectator] unless entity @s[tag=players] run function rks_extra:judgement
execute as @a[nbt={abilities:{mayfly:1b}}] unless entity @s[tag=players] run function rks_extra:judgement
execute as @a[nbt={Invulnerable:1b}] unless entity @s[tag=player] run function rks_extra:judgement
execute as @a unless entity @s[tag=player] if entity @s[nbt={Inventory:[{id:"minecraft:command_block"}]}] run function rks_extra:judgement