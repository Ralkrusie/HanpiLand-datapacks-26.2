"""
OGG 文件批量重命名
==================
用法: python t.py <目标文件夹路径>

功能:
  1. 将目标文件夹下所有 .ogg 文件名中的空格替换为下划线
  2. 英文字母全小写
  3. 删除末尾的下划线
"""

import sys
from pathlib import Path


def normalize_name(filename: str) -> str:
    """去掉 .ogg 扩展名, 空格→下划线, 全小写, 删末尾下划线, 加回扩展名"""
    name = filename[:-4] if filename.lower().endswith(".ogg") else filename
    name = name.replace(" ", "_")
    name = name.lower()
    name = name.rstrip("_")
    return name + ".ogg"


def process(target_dir: str) -> None:
    target = Path(target_dir)

    if not target.is_dir():
        print(f"错误: 目标文件夹不存在: {target}")
        sys.exit(1)

    ogg_files = sorted(target.glob("*.ogg"))
    if not ogg_files:
        print("没有找到 .ogg 文件。")
        return

    count = 0
    for ogg_path in ogg_files:
        new_name = normalize_name(ogg_path.name)
        new_path = ogg_path.with_name(new_name)
        if ogg_path == new_path:
            continue
        print(f"  {ogg_path.name}  ->  {new_name}")
        ogg_path.rename(new_path)
        count += 1

    print(f"\n完成: {count} 个文件已重命名。")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python t.py <目标文件夹路径>")
        sys.exit(1)
    process(sys.argv[1])

