SetTitleMatchMode, 2
SetTitleMatchMode, Fast
>+>^>!>#d::WinRestore, A
return

>+>^>!>#s::WinMaximize, A
return

>+>^>!>#f::WinMinimize, A
return

;Mozilla
>+>^>!>#e::
if WinExist("ahk_exe idea64.exe")
WinActivate,
else
run "C:\Program Files\JetBrains\IntelliJ IDEA 2019.2.3\bin\idea64.exe"
return

>+>^>!>#a::
WinActivate, ahk_exe Slack.exe
return

>+>^>!>#r::
if WinExist("ResophNotes ahk_class QWidget")
WinActivate,
else
run "C:\Tools\ResophNotes\ResophNotes.exe"
return

>+>^>!>#g::
if WinExist("ahk_class MozillaWindowClass")
WinActivate,
else
run "C:\Program Files\Mozilla Firefox\firefox.exe"
return

>+>^>!>#t::
WinActivate, ahk_exe Teams.exe
return 