;Overridden Capslock needs to be listed first for this to work
;ctrl+alt, capslock to unlock, alt+capslock to lock
!Capslock::
;Send {Capslock}
return
Capslock::return
+Capslock::return
^Capslock::return
^+Capslock::return

;#include capslock_eclipse_mod.ahk
#include capslock_idea_mod.ahk

;Send window to next Screen
Capslock & Tab::
if (GetKeyState("Shift"))
	Send {LWin Down}{Down}{LWin Up}
else
	Send {Shift Down}{LWin Down}{Right}{LWin Up}{Shift Up}
return

Capslock & s::
Send {Ctrl Down}s{Ctrl Up}
return

Capslock & u::
Click WheelUp
return

Capslock & m::
Click WheelDown
return

Capslock & p::
Send ckrw
return

Capslock & a::
Send {Ctrl Down}{a}{Ctrl Up}
return

Capslock & c::
Send {Ctrl Down}{c}{Ctrl Up}
return

Capslock & Enter::
Send {Ctrl Down}{Enter}{Ctrl Up}
return

Capslock & r::
if (GetKeyState("Shift")){
  Send {Shift Down}{Ctrl Down}{z}{Ctrl Up}{Shift Up}
} else{
  Send {Ctrl Down}{z}{Ctrl Up}
}

return

Capslock & y::
Send {Ctrl Down}{y}{Ctrl Up}
return

Capslock & t::
Send {Ctrl Down}{t}{Ctrl Up}
return

Capslock & g::
Send {Ctrl Down}{f}{Ctrl Up}
return

;Delete or Delete Current Line
Capslock & d::
if (GetKeyState("Shift")){
  Send {Home}
  Send {Shift Down}{End}{Shift Up}
  Send {BS}
} else{
  Send {Delete}
}
return

;Delete Forward
Capslock & f::
Send {Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}
Send {Delete}
return

;highlight current line
Capslock & n::
Send {Home}
Send {Shift Down}
Send {End}
Send {Shift Up}
return

;copy current line
Capslock & 7::
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

Capslock & v::
Send {Ctrl Down}{v}{Ctrl Up}
return

Capslock & z::
Send {Ctrl Down}{z}{Ctrl Up}
return

Capslock & x::
Send {Ctrl Down}{x}{Ctrl Up}
return

Capslock & -::
Send {Esc}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Capslock & Left::
Send {LWin Down}{Left}{LWin Up}
return

Capslock & Right::
Send {LWin Down}{Right}{LWin Up}
return

Capslock & Up::
Send {LWin Down}{Up}{LWin Up}
return

Capslock & Down::
Send {LWin Down}{Down}{LWin Up}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Ctrl+ Generic Tabbing
Capslock & 8::
Send {Ctrl Down}{PgUp}{Ctrl Up}
return

;Ctrl+PageDown Generic Tabbing
Capslock & 9::
Send {Ctrl Down}{PgDn}{Ctrl Up}
return

Capslock & 1::
if GetKeyState("Shift")
	Send {LWin Down}{Down}{LWin Up}
else
	Send {LWin Down}{Up}{LWin Up}
return

Capslock & Space::
Send {Ctrl Down}{Enter}{Ctrl Up}
return

;Move Desk Left
Capslock & 2::
if GetKeyState("Shift")
Send {Lwin Down}2{LWin Up}
else
Send {Ctrl Down}{LWin Down}{Left}{LWin Up}{Ctrl Up}
Return

;Move Desk Right
Capslock & 3::
if GetKeyState("Shift")
Send {Lwin Down}3{LWin Up}
else
Send {Ctrl Down}{LWin Down}{Right}{LWin Up}{Ctrl Up}
Return

;Show Desks
Capslock & 4::
if GetKeyState("Shift")
Send {Lwin Down}4{LWin Up}
else
Send {LWin Down}{Tab}{LWin Up}
Return

;Show Desks
Capslock & 5::
if GetKeyState("Shift")
Send {Lwin Down}5{LWin Up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Capslock & e::
if GetKeyState("Shift")
Send {Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}
else
Send {Ctrl Down}{Right}{Ctrl Up}
return

Capslock & w::
if GetKeyState("Shift")
Send {Ctrl Down}{w}{Ctrl Up}
else
Send {Ctrl Down}{Left}{Ctrl Up}
return

Capslock & i::
if GetKeyState("Shift")
Send {Shift Down}{Home}{Shift Up}
else
if GetKeyState("Ctrl")
Send {Ctrl Down}{Home}{Ctrl Up}
else
Send {Home}
return

Capslock & o::
if GetKeyState("Shift")
Send {Shift Down}{End}{Shift Up}
else
if GetKeyState("Ctrl")
Send {Ctrl Down}{End}{Ctrl Up}
else
Send {End}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Capslock & j::
if GetKeyState("Shift")
Send {Shift Down}{Down}{Shift Up}
else
Send {Down}
return

Capslock & k::
if GetKeyState("Shift")
Send {Shift Down}{Up}{Shift Up}
else
Send {Up}
return

Capslock & h::
if GetKeyState("Shift")
Send {Shift Down}{Left}{Shift Up}
else
Send {Left}
return

Capslock & l::
if GetKeyState("Shift")
Send {Shift Down}{Right}{Shift Up}
else
Send {Right}
return

Capslock & MButton::
Send {Enter}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SC163::
;MsgBox, %A_ThisHotkey% was pressed.
;return

;Send {vkFFsc159}

