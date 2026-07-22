# 初始化防爆区存储（仅在首次加载时设置默认区域）
# 如果存储中已存在区域数据，则保留现有数据（支持热编辑后 /reload 不丢失）
execute unless data storage rks_extra:storage tnt_free.areas run data modify storage rks_extra:storage tnt_free.areas set value [{x:-1100,y:-64,z:0,dx:700,dy:384,dz:600},{x:-250,y:-64,z:400,dx:250,dy:384,dz:250},{x:65,y:-64,z:-600,dx:300,dy:384,dz:300},{x:-660,y:-64,z:-1400,dx:1440,dy:384,dz:400},{x:1600,y:-64,z:-1750,dx:340,dy:384,dz:160}]
