@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 如果没有records文件夹就创建它
if not exist "records" mkdir records

:: 批量处理 - 支持 ogg / mp3 / wav / flac / m4a / aac / wma / opus
for %%i in (*.ogg *.mp3 *.wav *.flac *.m4a *.aac *.wma *.opus) do (
    echo 正在处理: %%i
    ffmpeg -i "%%i" -vn -c:a libvorbis -ar 44100 -q:a 5 -map_metadata -1 -ac 1 "records\%%~ni.ogg" -y
)

echo 全部转换完成！
pause