# 宏函数：用 tellraw 显示单个防爆区（名称 + 起点 → 终点格式）
# 参数: $(idx), $(name), $(x), $(y), $(z), $(ex), $(ey), $(ez)（由 list_step 合并传入）
$tellraw @s [{text:"[$(idx)] ",color:gold},{text:"「$(name)」 ",color:green},{text:"(",color:gray},{text:"$(x)",color:white},{text:", ",color:gray},{text:"$(y)",color:white},{text:", ",color:gray},{text:"$(z)",color:white},{text:")  →  (",color:gray},{text:"$(ex)",color:white},{text:", ",color:gray},{text:"$(ey)",color:white},{text:", ",color:gray},{text:"$(ez)",color:white},{text:")",color:gray}]
