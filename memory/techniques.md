# 技巧总结 (26.2+)

> **目的**: 记录数据包开发中的最佳实践、设计模式和实用技巧。
> **格式**: 每个技巧包含标题、适用场景、代码示例、注意事项。

---

## 目录

1. [Storage 操作模式](#storage-操作模式)
2. [函数宏 (Macros)](#函数宏-macros)
3. [记分板 (Scoreboard)](#记分板-scoreboard)
4. [Dialog GUI 模式](#dialog-gui-模式)
5. [性能优化](#性能优化)
6. [调试技巧](#调试技巧)
7. [与玩家交互的模式](#与玩家交互的模式)

---

## Storage 操作模式

### 使用 storage 而非 scoreboard 存储文本
- **原则**: scoreboard 只能存数字，文本应存于 storage
- **适用**: 任何需要存储字符串的场景

```mcfunction
# 存储数据
data modify storage newspaper:data notice append value {id:1, title:"公告", body:"内容"}

# 读取数据
data get storage newspaper:data notice[0].title

# 复制数据
data modify storage temp:cache current_notice set from storage newspaper:data notice[0]
```

### 用 macro 遍历数组
```mcfunction
# 调用方
$function newspaper:render_notice {index:0, total:5}

# render_notice.mcfunction
data get storage newspaper:data notice[$(index)].title
$function newspaper:render_notice {index:$(($(index)+1)), total:$(total)}
## 注意: 需要边界检查, index >= total 时停止
```

---

## 函数宏 (Macros)

### 基本原理
- 函数宏在调用时展开 `$()` 变量
- 支持数学运算: `$((a+b))`
- 适用于需要动态参数的场景

```mcfunction
# 定义宏函数 (macro)
$function rks_civil:give_item {item:"minecraft:diamond", count:1}
# 展开后: give @s minecraft:diamond 1
```

### 注意事项
- 宏函数中不能用 `$()` 做条件判断，只能做值替换
- 宏函数执行时 `@s` 可能不指向调用者，注意实体上下文
- 避免过深层递归，macro 展开也计入 function 调用深度限制

---

## 记分板 (Scoreboard)

### 常用模式

```mcfunction
# 创建记分板 (dummy 类型)
scoreboard objectives add newspaper_id dummy

# 自增 ID 生成
scoreboard players add #next_id newspaper_id 1
scoreboard players operation @s newspaper_id = #next_id newspaper_id

# 条件检查
execute if score @s newspaper_id matches 1.. run ...

# 比较
execute if score @s a = #global b run ...
```

### 避免过度使用
- 不要用 scoreboard 存储文本
- 大量 scoreboard 操作会影响性能
- 考虑用 predicates 替代简单的数值条件

---

## Dialog GUI 模式

<!-- 在此添加 Dialog 相关的实用模式 -->

### 占位符（待补充）

---

## 性能优化

### 减少每刻执行
- 不要在 `#minecraft:tick` 中做复杂操作
- 用 `/schedule` 降低执行频率
- 用 predicates 做条件过滤，减少不必要的函数调用

```mcfunction
# 每 20 刻执行一次 (1秒)
schedule function namespace:heavy_task 20t
```

### 函数调用深度
- 函数调用链有深度限制（约 256-512 层）
- 避免深层递归
- 长循环用 `/schedule` 分帧执行

### 避免大量 NBT 操作
- `data get` 和 `data modify` 在整个 storage 上操作较慢
- 尽量用路径精确访问小范围数据
- 避免在 tick 函数中遍历大型数组

---

## 调试技巧

### 使用 tellraw 输出变量
```mcfunction
# 查看 storage 值
data get storage newspaper:data notice[0]
# 手动查看输出
```

### 使用进度做标记
- 设置 `minecraft:impossible` 触发器的手动进度
- 在函数中 `/advancement grant` 来标记执行路径
- 完成/撤销进度可追踪代码流

### 预测结果
- 先在单机世界测试
- 用 `/function` 手动调用确认返回值
- 使用 `/return` 传递调试信息

---

## 与玩家交互的模式

### 检测物品点击 (Carrot on a Stick / Knowledge Book)
```mcfunction
# 用胡萝卜钓竿检测右键
# 或使用 knowledge book + 进度触发器
```

### 使用 Dialog 替代聊天输入
- 优先使用 Dialog GUI 做选项交互
- 避免依赖 `/trigger` 聊天交互（不直观）
- Dialog 支持多级菜单

<!-- 在此添加更多交互模式 -->

---

> **提示**: 发现新的实用技巧时，请添加到对应分类下，并标注发现日期和适用版本。
