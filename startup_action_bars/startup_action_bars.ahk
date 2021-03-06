﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
mouseAccelEnabled:=false
SetCapsLockState, alwaysoff
;Tip: accent mark ` is an escape character

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#Include alt_bars.ahks
;#Include mouse_three_mod.ahk
#Include capslock_mod.ahk
#Include projectnames.ahk
;#Include scratch.ahk
#Include memes.ahk
#Include xbutton_mod.ahk 
#Include ssh_session.ahk
#Include windows.ahk

::/rld::
Reload
return

^!PrintScreen::
run "C:\scripts\olss"
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
Send mysql -ureddwerks -preddwerks reddwerks
return

::/mysqld::
Send mysqldump.exe --single-transaction --triggers --routines --no-autocommit -e -K --databases -uroot -p reddwerks reporting > 
return

;Mozilla [W]
::ezdox::
if WinExist("Ergodox EZ Configurator - Mozilla Firefox")
WinActivate,
else
run "C:\Program Files\Mozilla Firefox\firefox.exe" "https://configure.ergodox-ez.com/"
return

#Include multi_text_clip.ahk
;#Include multi_text_clip_csa.ahk
;#Include multi_text_clip_hmc.ahk
;#Include string_manipulation.ahk
;#Include vim_anywhere.ahk
;#Include last_key_pressed.ahk
#Include center_all_windows.ahk
