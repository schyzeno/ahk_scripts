start gtabs.lnk
rem monitor0 is small laptop screen when in dual monitor mode
start monitor0_bottom_left /k "cdscripts && imqbrokerd" 
rem start monitor0_upper_right /k 
start monitor0_upper_left /k "cdscripts && weblog"
start monitor0_bottom_right /k "cdscripts && ipconfig && mysqlshow -uroot -proot"
rem start vs2008 and eclipse
start /min "" "C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe"
start /min "" "C:\Users\phannt\eclipse\jee-neon\eclipse\eclipse.exe"
start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook 2016"
start "" "C:\Program Files (x86)\Evernote\Evernote\Evernote.exe"
start /min "" "C:\Program Files (x86)\Samsung\SideSync4\SideSync.exe"
start cmd /c "C:\Users\phannt\AppData\Local\GPMDP_3\Update.exe --processStart "Google Play Music Desktop Player.exe""
rem monitor1
start monitor1_upper_right /k "cdworkspace && mcigupdate"
start cmd /c "cdtomcat && startup"
move_tomcat.ahk
move_gtabs.ahk
move_evernote.ahk
move_outlook.ahk
exit