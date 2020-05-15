#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
mouseAccelEnabled:=false
SetCapsLockState, alwaysoff
;Tip: accent mark ` is an escape character

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#Include alt_bars.ahks
#Include mouse_three_mod.ahk
#Include capslock_mod.ahk
#Include projectnames.ahk
;#Include scratch.ahk
#Include memes.ahk
#Include xbutton_mod.ahk
#Include ssh_session.ahk
#Include windows.ahk
!-::
send {PrintScreen}
return

^!PrintScreen::
run "C:\scripts\olss"
return

PgUp::AppsKey
return

#a::
Send {Lwin Down}
Sleep 100
Send {Left}
Sleep 100
Send {Lwin Up}
Sleep 100
Send {Escape}
return

#w::
Send #{Up}
return

#d::
Send #{Right}
Sleep 100
Send {Escape}
return

#s::
Send #{Down}
return

::/cmdd::
run "C:\scripts\cmd_center"
return

::/s8f::
Send select * from
return

::/sf8::
Send select * from
Send {Space}
return

::/mysqlu::
Send mysql -ureddwerks -preddwerks ptlreddwerks
return

::/mysqlm::
Send mysql -ureddwerks -pminotR3dWerk{!} ptlreddwerks
return

::/scripts::
Send cd /opt/reddwerks/scripts/linux-x86-64
return

::/logs::
Send cd /opt/reddwerks/logs
return

::/backup::
Send cd /opt/backup/db/testing
return

!Space::
run "C:\scripts\cmd_center"
return

;NumpadEnter::
;Send {Space}
;return

^Numpad7::
run "C:\Program Files\Notepad++\notepad++.exe" "C:\scripts\startup_action_bars\startup_action_bars.ahk"
return

^Numpad8::
Reload
return

^Numpad9::
run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AutoHotkey\Active Window Info (Window Spy)"
return

^Numpad0::
Send {F5}
return

#Include multi_text_clip.ahk
#Include string_manipulation.ahk
;#Include vim_anywhere.ahk
;#Include last_key_pressed.ahk
