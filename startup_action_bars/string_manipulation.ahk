tempClipBoard:=

;Delete back One word
+BS::
Send {Ctrl Down}{Shift Down}{Left}
Send {Shift Up}{Ctrl Up}
Send {BS}
return

;Delete current line
^+d::
Input key, I L1
IfEqual key,d
   Send {Home}
   Send {Shift Down}{End}{Shift Up}
   Send {BS}
return

;Copy and paste line
!End::
tempClipBoard:=clipboard
Send {Home}
Send {Shift Down}
Send {End}
Send {Shift Up}
Send ^c
Send {End}
Send {Enter}
Send ^v
sleep 1000
clipboard=%tempClipBoard%
return
