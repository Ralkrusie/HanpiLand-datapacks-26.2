tellraw @s [{text:"\n===== 🛡️ rks_civil 管理面板 =====\n",color:"gold",bold:true}]
tellraw @s [{text:"  [📊 系统状态]  ",color:"aqua",click_event:{action:"run_command",command:"function rks_civil:admin_panel/dashboard"}},{text:"\n"}]
tellraw @s [{text:"  [🏙️ 区域管理]  ",color:"aqua",click_event:{action:"run_command",command:"function rks_civil:admin_panel/areas"}},{text:"\n"}]
tellraw @s [{text:"\n💡 手持面板右键即可重新打开",color:"gray",italic:true}]
