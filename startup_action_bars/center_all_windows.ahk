;Centers Active Window
>+>^>!>#F3::
WinExist("A")
WinGetPos,,, sizeX, sizeY
;WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
WinMove, (A_ScreenWidth/2)-(sizeX/2), 0
return

;Restores and Centers All Window
>+>^>!>#F2::
WinGet windows, List
TaskBarWindows := [] 
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle title, ahk_id %id%
	If (title = "")
		continue
	WinGetClass class, ahk_id %id%	
	If (class = "ApplicationFrameWindow") 
	{
		WinGetText, text, ahk_id %id%		
		If (text = "")
		{
			WinGet, style, style, ahk_id %id%
			If !(style = "0xB4CF0000")	 ; the window isn't minimized
				continue
		}
	}
	WinGet, style, style, ahk_id %id%
	if !(style & 0xC00000) ; if the window doesn't have a title bar
	{
		; If title not contains ...  ; add exceptions
			continue
	}
	TaskBarWindows.Push(title)
}

for index, element in TaskBarWindows
{    
    ;MsgBox % "Element number " . index . " is " . element
	WinExist(element)
	WinActivate,
	WinRestore, %element%
	WinGetPos,,, sizeX, sizeY
	WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)	
}

return
