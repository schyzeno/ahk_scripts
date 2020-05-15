;Default Settings
;;;;;;;;;;;;;;;;;
loopCount=3
xcor=200
ycor=200
xcor2=300
ycor2=300
container=10097273
upc=09806348828
sleepTime=500
breakLoop=0
;;;;;;;;;;;;;;;;;

splashText=
(
===========================
RF SELECTION - CLUSTER PICKING BOT v1.2
===========================
HotKeys:
Ctrl+5 	-> Run Main Script	
	Types Container then wait.
	Press Enter Key then wait.
	Performs Click1 then wait.
	Performs Click2 then wait.
	Press Enter Key then wait.
	Types UPC then wait.
	Press Enter Key then wait.
	Press Esc Key then wait.
	Press Enter Key then wait*2.
	Then Loops.	
Ctrl+9 	-> Change Main Script Settings
Ctrl+1	-> Stops Main on next loop
			(Might have to spam)
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Alt+1	-> Set Click1 Coordinates
Alt+2	-> Set Click2 Coordinates
Alt+3	-> Current Mouse Coordinates
Alt+5	-> Run Mouse Move Test
	Only moves the mouse	
	Moves mouse then wait.
	Moves mouse then wait.
Alt+9  	-> Change Click Coordinates
Alt+F1	-> Show Help
Notes:
	Mouse coordinates are relative
	to active window.
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Settings:
Loop		= %loopCount%
Click1-X-Coord	= %xcor%
Click1-Y-Coord	= %ycor%
Click1-X-Coord	= %xcor2%
Click1-Y-Coord	= %ycor2%
Container	= %container%
UPC		= %upc%
Action Wait Time	= %sleepTime% ms
)
MsgBox, %splashText%

;Run Main Script
;;;;;;;;;;;;;;;;;

^5::
breakLoop=0
loop %loopCount% {
if(breakLoop = 1)
	break
	
Send %container%
sleep sleepTime

Send {Enter}
sleep sleepTime

MouseClick, left, xcor, ycor
sleep sleepTime

MouseClick, left, xcor2, ycor2
sleep sleepTime

Send {Enter}
sleep sleepTime

Send %upc%
sleep sleepTime

Send {Enter}
sleep sleepTime

Send {Esc}
sleep sleepTime

Send {Enter}
sleep sleepTime
sleep sleepTime
}
return

;Change Main Script Settings
;;;;;;;;;;;;;;;;;
^9::
;Sample Input Box
;InputBox, xcor , Settings, Enter X-Coord on Click-1 (values are relative to window),HIDE, Width, Height, X, Y, Font, Timeout,Default
InputBox, loopCount , Settings, Enter number of times to loop, 							 , 300, 150, , , , ,%loopCount%
InputBox, xcor 		, Settings, Enter X-Coord on Click-1 (values are relative to window),, 300, 150, , , , ,%xcor%
InputBox, ycor 		, Settings, Enter Y-Coord on Click-1 (values are relative to window),, 300, 150, , , , ,%ycor%
InputBox, xcor2 	, Settings, Enter X-Coord on Click-2 (values are relative to window),, 300, 150, , , , ,%xcor2%
InputBox, ycor2 	, Settings, Enter Y-Coord on Click-2 (values are relative to window),, 300, 150, , , , ,%ycor2%
InputBox, container , Settings, Enter container, 		 , 300, 150, , , , ,%container%
InputBox, upc 		, Settings, Enter upc, 					 , 300, 150, , , , ,%upc%
InputBox, sleepTime , Settings, Enter time(ms) to wait between actions, 				 , 300, 150, , , , ,%sleepTime%
return

;Run Click Test Script
;;;;;;;;;;;;;;;;;
!5::
MouseMove, xcor, ycor
sleep sleepTime

MouseMove, xcor2, ycor2
sleep sleepTime
return

!1::
MouseGetPos , xcor, ycor,
return

!2::
MouseGetPos , xcor2, ycor2,
return

!3::
;MouseGetPos , OutputVarX, OutputVarY, OutputVarWin, OutputVarControl, Flag
xpos=ypos=
MouseGetPos , xpos, ypos,
MsgBox, Relative MousePosition (X=%xpos%, Y=%ypos%) 
return

!9::
InputBox, xcor , Settings, Enter X-Coord on Click-1 (values are relative to window), 	, 300, 150, , , , ,%xcor%
InputBox, ycor , Settings, Enter Y-Coord on Click-1 (values are relative to window), 	, 300, 150, , , , ,%ycor%
InputBox, xcor2 , Settings, Enter X-Coord on Click-2 (values are relative to window), 	, 300, 150, , , , ,%xcor2%
InputBox, ycor2 , Settings, Enter Y-Coord on Click-2 (values are relative to window), 	, 300, 150, , , , ,%ycor2%
return

!F1::
MsgBox, %splashText%
return

^1::
breakLoop=1
return