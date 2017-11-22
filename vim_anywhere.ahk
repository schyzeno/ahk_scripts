; accents ` below escape a character
; toggleVim can just as easily be called NormalMode
toggleVim:=false
; When users enteres vim Mode, the user will be in "Normal Mode" initially. In order to insert text, user must enter insertMode
insertMode:=false
normalMode:=false
showMessage:=false
countMode:=false
count:=1

::./vim::
if (toggleVim)
{
	toggleVim:=false
	count:=1
	countMode:=false
	insertMode:=false
	normalMode:=false
	MsgBox Vim disabled
}
else
{
	toggleVim:= true
	normalMode:= true
	insertMode:= false
	MsgBox Vim enabled
}
return

^`;::
if (toggleVim)
{
	toggleVim:=false
	count:=1
	countMode:=false
	insertMode:=false
	normalMode:=false
	MsgBox Vim disabled
}
else
{
	toggleVim:=true
	normalMode:=true
	insertMode:=false
	MsgBox Vim enabled
}
return

#If (insertMode)
Escape::
count:=1
countMode:=false
insertMode:=false
normalMode:=true
return

#If (normalMode)
i::
insertMode:=true
normalMode:=false
send {Left}
return

+i::
insertMode:=true
normalMode:=false
send {Home}
return

a::
insertMode:=true
normalMode:=false
return

+a::
insertMode:=true
normalMode:=false
Send {End}
return

o::
insertMode:=true
normalMode:=false
Send {End}
Send {Enter}
return

+o::
insertMode:=true
normalMode:=false
Send {Up}
Send {End}
Send {Enter}
return

b::
loop %count%
{
Send ^{Left}
}
count:=1
countMode:= false
return

w::
loop %count%
{
Send ^{Right}
}
count:=1
countMode:= false
return

h::
loop %count%
{
Send {Left}
}
count:=1
countMode:= false
return

j::
loop %count%
{
Send {Down}
}
count:=1
countMode:= false
return

k::
loop %count%
Send {Up}
count:=1
countMode:= false
return

l::
loop %count%
Send {Right}
count:=1
countMode:= false
return

0::
if (countMode)
	count:= (count * 10) + 0
else
{		
	count:=1
	countMode:= false
	Send {Home}
}
return

1::
if (countMode)
{
	count:= (count * 10) + 1
}
else
{
	countMode:=true
	count:= 1
}
return

2::
if (countMode)
	count:= (count * 10) + 2
else
{
	countMode:=true
	count:= 2
}
return

3::
if (countMode)
	count:= (count * 10) + 3
else
{
	countMode:=true
	count:= 3
}
return

4::
if (countMode)
	count:= (count * 10) + 4
else
{
	countMode:=true
	count:= 4
}
return

5::
if (countMode)
	count:= (count * 10) + 5
else
{
	countMode:=true
	count:= 5
}
return

6::
if (countMode)
	count:= (count * 10) + 6
else
{
	countMode:=true
	count:= 6
}
return

7::
if (countMode)
	count:= (count * 10) + 7
else
{
	countMode:=true
	count:= 7
}
return

8::
if (countMode)
	count:= (count * 10) + 8
else
{
	countMode:=true
	count:= 8
}
return

9::
if (countMode)
	count:= (count * 10) + 9
else
{
	countMode:=true
	count:= 9
}
return


+4::		
count:=1
countMode:= false
Send {End}
return


