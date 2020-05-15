;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Shortcut for Intellij Find in Files
Capslock & q::
Send {Shift}{Shift}
return

;use to close windows
Capslock & F4::
Send {Ctrl Down}F4{Ctrl Up}
return

;Collapse All 
;Expand All

;Heiarchy
!o::
Send {Ctrl Down}{F12}{Ctrl Up}
return

;Bookmark
Capslock & ,::
Send {Ctrl Down}{F11}{Ctrl Up}
return

;Go to Line
Capslock & .::
Send {Ctrl Down}g{Ctrl Up}
return

;Find text in Files
Capslock & b::
Send {Ctrl Down}{Shift Down}f{Shift Up}{Ctrl Up}
return

;Go to Declaration
F3::
Send {Ctrl Down}b{Ctrl Up}
return

;Maximize Editor
;Capslock & F12::
;Send {Ctrl Down}{Shift Down}F12{Shift Up}{Ctrl Up}
;return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;