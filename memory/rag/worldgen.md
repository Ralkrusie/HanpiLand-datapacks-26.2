# 世界生成参考 (26.2+)

> 自定义世界生成: https://minecraft.wiki/w/Custom_world_generation
> 噪声设置: https://minecraft.wiki/w/Noise_settings
> 生物群系: https://minecraft.wiki/w/Biome
> 维度类型: https://minecraft.wiki/w/Dimension_type
> 雕刻器: https://minecraft.wiki/w/Carver
> 特征 (Features): https://minecraft.wiki/w/Feature
> 结构: https://minecraft.wiki/w/Structure
> 密度函数: https://minecraft.wiki/w/Density_function

---

## 世界生成文件结构

```
data/<namespace>/worldgen/
├── biome/               # 生物群系定义
├── configured_carver/   # 雕刻器
├── configured_feature/  # 配置特征
├── density_function/    # 密度函数
├── noise/               # 噪声参数
├── noise_settings/      # 噪声设置
├── placed_feature/      # 放置特征
├── processor_list/      # 结构处理器列表
├── structure/           # 结构定义
├── structure_set/       # 结构集
├── template_pool/       # 模板池 (拼图结构)
├── dimension_type/      # 维度类型 (JSON)
├── dimension/           # 维度定义
├── flat_level_generator_preset/  # 超平坦预设
└── world_preset/        # 世界预设
```

## 密度函数 (1.19+ / 26.2)

- 参考: https://minecraft.wiki/w/Density_function
- 用于定义地形形状，取代旧噪声设置中的部分参数
- 类型: `constant`, `add`, `mul`, `min`, `max`, `range`, `abs`, `square`, `cube`, `half_negative`, `quarter_negative`, `squeeze`, `noise`, `shifted_noise`, `old_blended_noise`, `y_clamped_gradient`, `flat_cache`, `cache_2d`, `cache_once`, `interpolated`, `blend_alpha`, `blend_offset`, `end_islands`, `weird_scaled_sampler`, `shift_a`, `shift_b`, `slide`, `clamp`

## 放置特征 (Placed Features)

- 特征类型列表: https://minecraft.wiki/w/Feature#List_of_features
- 放置修饰器: https://minecraft.wiki/w/Placed_feature#Placement_modifiers

---

> **使用方式**: 世界生成是最复杂的部分之一，务必查阅上方链接确认当前版本的语法。
