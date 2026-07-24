"""
音频批量转换脚本：将指定目录下的音频文件全部转为单声道 OGG 格式。
依赖：ffmpeg（需在系统 PATH 中可用）

用法：
    python convert_to_mono_ogg.py              # 默认处理 ../temp 目录
    python convert_to_mono_ogg.py <目录路径>    # 处理指定目录
"""

import os
import sys
import subprocess
import argparse
from pathlib import Path

# 支持的输入音频格式
SUPPORTED_EXTENSIONS = {
    '.wav', '.mp3', '.flac', '.aac', '.m4a', '.wma',
    '.aiff', '.ape', '.ogg', '.opus', '.webm', '.mp2',
    '.ac3', '.dts', '.wv', '.tta',
}


def find_audio_files(directory: Path) -> list[Path]:
    """查找目录下所有支持的音频文件（仅顶层，不递归）。"""
    audio_files = []
    for file in directory.iterdir():
        if file.is_file() and file.suffix.lower() in SUPPORTED_EXTENSIONS:
            audio_files.append(file)
    return sorted(audio_files)


def convert_to_mono_ogg(input_path: Path, output_path: Path) -> bool:
    """使用 ffmpeg 将单个音频文件转为单声道 OGG Vorbis。"""
    cmd = [
        'ffmpeg', '-y',           # -y: 覆盖已有输出文件
        '-i', str(input_path),     # 输入文件
        '-vn',                     # 丢弃视频流（Minecraft 不兼容带视频轨的 OGG）
        '-ac', '1',               # 单声道
        '-c:a', 'libvorbis',      # OGG Vorbis 编码器
        str(output_path),
    ]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"  [错误] {input_path.name}: {result.stderr.strip()}")
        return False
    return True


def main():
    parser = argparse.ArgumentParser(
        description='将目录下的音频文件批量转为单声道 OGG 格式'
    )
    parser.add_argument(
        'directory', nargs='?', default=None,
        help='音频文件所在目录（默认：脚本所在目录的父文件夹下的 temp）'
    )
    args = parser.parse_args()

    # 确定目标目录
    if args.directory:
        target_dir = Path(args.directory).resolve()
    else:
        script_dir = Path(__file__).resolve().parent
        target_dir = script_dir.parent / 'temp'

    if not target_dir.exists():
        print(f"目录不存在: {target_dir}")
        sys.exit(1)

    if not target_dir.is_dir():
        print(f"路径不是目录: {target_dir}")
        sys.exit(1)

    # 查找音频文件
    audio_files = find_audio_files(target_dir)
    if not audio_files:
        print(f"在 {target_dir} 中未找到支持的音频文件")
        sys.exit(0)

    print(f"目标目录: {target_dir}")
    print(f"找到 {len(audio_files)} 个音频文件\n")

    success_count = 0
    for audio_file in audio_files:
        output_file = audio_file.with_suffix('.ogg')
        print(f"转换中: {audio_file.name} -> {output_file.name}")
        if convert_to_mono_ogg(audio_file, output_file):
            success_count += 1
            audio_file.unlink()
            print(f"  已删除原文件: {audio_file.name}")

    print(f"\n完成！{success_count}/{len(audio_files)} 个文件转换成功。")


if __name__ == '__main__':
    main()
