@echo off
for /f "delims=" %%x in ('dir C:\Users\phannt\Desktop\Autopicpick /b /o-d') do (
set "filename=%%x"
goto :open_pic
)
:open_pic
"C:\Users\phannt\Desktop\Autopicpick\%filename%"
