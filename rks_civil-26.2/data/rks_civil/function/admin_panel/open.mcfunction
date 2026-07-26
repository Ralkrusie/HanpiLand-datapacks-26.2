tellraw @s [{text:"\n===== 🛡️ 服务器信息管理面板 =====\n",color:"gold",bold:true}]
tellraw @s [{text:"  [📊 系统状态]  ",color:"aqua",click_event:{action:"run_command",command:"function rks_civil:admin_panel/dashboard"}},{text:"\n"}]
tellraw @s [{text:"  [🏙️ 区域管理]  ",color:"aqua",click_event:{action:"run_command",command:"function rks_civil:admin_panel/areas"}}]
