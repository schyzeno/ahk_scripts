MButton::
return

;Send window to next Screen
MButton & Tab::
if (GetKeyState("Shift"))
	Send {LWin Down}{Down}{LWin Up}
else
	Send {Shift Down}{LWin Down}{Right}{LWin Up}{Shift Up}
return

MButton & s::
Send {Ctrl Down}s{Ctrl Up}
return

MButton & a::
Send {Ctrl Down}a{Ctrl Up}
return

MButton & u::
Click WheelUp
return

MButton & m::
Click WheelDown
return

MButton & p::
Send ckrw
return

MButton & c::
Send {Ctrl Down}{c}{Ctrl Up}
return


MButton & r::
Send {Ctrl Down}{z}{Ctrl Up}
return

MButton & y::
Send {Ctrl Down}{y}{Ctrl Up}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Shortcut for Eclipse Find in Files
MButton & q::
Send {Shift Down}{Ctrl Down}{r}{Ctrl Up}{Shift Up}
return

MButton & [:: 
Send {Alt Down}{Left}{Alt Up}
return

MButton & ]::
Send {Alt Down}{Right}{Alt Up}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Delete or Delete Current Line
MButton & d::
if (GetKeyState("Shift")){
  Send {Home}
  Send {Shift Down}{End}{Shift Up}
  Send {BS}
} else{
  Send {Delete}
}
return

;Delete Forward
MButton & f::
Send {Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}
Send {Delete}
return

;highlight current line
MButton & n::
Send {Home}
Send {Shift Down}
Send {End}
Send {Shift Up}
return

;copy current line
Mbutton & 7::
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

MButton & v::
Send {Ctrl Down}{v}{Ctrl Up}
return

MButton & z::
Send {Ctrl Down}{z}{Ctrl Up}
return

MButton & x::
Send {Ctrl Down}{x}{Ctrl Up}
return

MButton & -::
Send {Esc}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MButton & Left::
Send {LWin Down}{Left}{LWin Up}
return

MButton & Right::
Send {LWin Down}{Right}{LWin Up}
return

MButton & Up::
Send {LWin Down}{Up}{LWin Up}
return

MButton & Down::
Send {LWin Down}{Down}{LWin Up}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Ctrl+ Generic Tabbing
MButton & 8::
Send {Ctrl Down}{PgUp}{Ctrl Up}
return

;Ctrl+PageDown Generic Tabbing
MButton & 9::
Send {Ctrl Down}{PgDn}{Ctrl Up}
return

MButton & 1::
if GetKeyState("Shift")
	Send {LWin Down}{Down}{LWin Up}
else
	Send {LWin Down}{Up}{LWin Up}
return

MButton & Space::
Send {Ctrl Down}{Enter}{Ctrl Up}
return

;Move Desk Left
MButton & 2::
if GetKeyState("Shift")
Send {Lwin Down}2{LWin Up}
else
Send {Ctrl Down}{LWin Down}{Left}{LWin Up}{Ctrl Up}
Return

;Move Desk Right
MButton & 3::
if GetKeyState("Shift")
Send {Lwin Down}3{LWin Up}
else
Send {Ctrl Down}{LWin Down}{Right}{LWin Up}{Ctrl Up}
Return

;Show Desks
MButton & 4::
if GetKeyState("Shift")
Send {Lwin Down}4{LWin Up}
else
Send {LWin Down}{Tab}{LWin Up}
Return

;Show Desks
MButton & 5::
if GetKeyState("Shift")
Send {Lwin Down}5{LWin Up}
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MButton & g::
if GetKeyState("Shift")
Send {Ctrl Down}{End}{Ctrl Up}
else
Send {Ctrl Down}{Home}{Ctrl Up}
return

MButton & e::
if GetKeyState("Shift")
Send {Shift Down}{Ctrl Down}{Right}{Ctrl Up}{Shift Up}
else
Send {Ctrl Down}{Right}{Ctrl Up}
return

MButton & w::
if GetKeyState("Shift")
Send {Shift Down}{Ctrl Down}{Left}{Ctrl Up}{Shift Up}
else
Send {Ctrl Down}{Left}{Ctrl Up}
return

MButton & i::
if GetKeyState("Shift")
Send {Shift Down}{Home}{Shift Up}
else
if GetKeyState("Ctrl")
Send {Ctrl Down}{Home}{Ctrl Up}
else
Send {Home}
return

MButton & o::
if GetKeyState("Shift")
Send {Shift Down}{End}{Shift Up}
else
if GetKeyState("Ctrl")
Send {Ctrl Down}{End}{Ctrl Up}
else
Send {End}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MButton & j::
if GetKeyState("Shift")
Send {Shift Down}{Down}{Shift Up}
else
Send {Down}
return

MButton & k::
if GetKeyState("Shift")
Send {Shift Down}{Up}{Shift Up}
else
Send {Up}
return

MButton & h::
if GetKeyState("Shift")
Send {Shift Down}{Left}{Shift Up}
else
Send {Left}
return

MButton & l::
if GetKeyState("Shift")
Send {Shift Down}{Right}{Shift Up}
else
Send {Right}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SC163::
;MsgBox, %A_ThisHotkey% was pressed.
;return

;Send {vkFFsc159}

