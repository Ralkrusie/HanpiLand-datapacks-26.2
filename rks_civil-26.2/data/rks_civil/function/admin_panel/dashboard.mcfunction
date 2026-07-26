tellraw @s [{text:"\n===== 📊 系统状态 =====\n",color:"gold",bold:true}]
tellraw @s [{text:"在线玩家: ",color:"gray"},{selector:"@a",color:"green",separator:{text:", ",color:"gray"}}]
tellraw @s [{text:"区域总数: ",color:"gray"},{text:"请使用「区域管理」查看",color:"white"}]
tellraw @s [{text:"\n  [🔄 刷新]  ",color:"aqua",click_event:{action:"run_command",command:"function rks_civil:admin_panel/dashboard"}},{text:"  ",color:"white"},{text:"[↩ 返回]  ",color:"gold",click_event:{action:"run_command",command:"function rks_civil:admin_panel/open"}}]
