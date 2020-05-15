;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Shortcut for Eclipse Find in Files
Capslock & q::
Send {Shift Down}{Ctrl Down}{r}{Ctrl Up}{Shift Up}
return

Capslock & [:: 
Send {Alt Down}{Left}{Alt Up}
return

Capslock & ]::
Send {Alt Down}{Right}{Alt Up}
return

;use to close windows
Capslock & F4::
Send {Ctrl Down}w{Ctrl Up}
return

;Eclipse Collapse All 
Capslock & F11::
Send {Ctrl Down}{Shift Down}{NumpadDiv}{Shift Up}{Ctrl Up}
return
;Eclipse Expand All
Capslock & F12::
Send {Ctrl Down}{Shift Down}{NumpadMult}{Shift Up}{Ctrl Up}
return

;Bookmark
Capslock & ,::
Send {Ctrl Down},{Ctrl Up}
return
;Got o Line
Capslock & .::
Send {Ctrl Down}l{Ctrl Up}
return
;Find text in Files
Capslock & b::
Send {Ctrl Down}h{Ctrl Up}
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;