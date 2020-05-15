@echo off
for /f "delims=" %%x in ('dir C:\Users\phannt\Desktop\AutoPicpick /b /o-d') do (
set "filename=%%x"
goto :open_pic
)
:open_pic
"C:\Program Files (x86)\PicPick\picpick.exe" "C:\Users\phannt\Desktop\Autopicpick\%filename%"
