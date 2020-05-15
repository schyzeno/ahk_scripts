!1::WinMaximize, A
return

!2::WinRestore, A
return

!3::WinMinimize, A
return

;!4::
;run tail -f C:\opt\reddwerks\logs\webui-or-rf.log
;return

;Open Last Screen Shot
;!5::
;run "C:\scripts\olss.bat"
;return

;!6::
;mouseAccelEnabled:=!mouseAccelEnabled
;if(mouseAccelEnabled)
;	run C:\scripts\MouseAccelToggler\MouseAccelToggler.exe accel=on
;else
;	run C:\scripts\MouseAccelToggler\MouseAccelToggler.exe accel=off
;return


;!7::
;return
;
;!8::
;Send redworkone
;return
;
;!9::
;send // TODO
;send {Enter}
;send return null;
;return
;
;!0::
;run "C:\scripts\ahk\vim.ahk"
;return