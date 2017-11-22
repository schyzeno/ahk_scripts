var1:=
var2:=
var3:=
var4:=
var5:=
var6:=
var7:=
var8:=
var9:=
var0:=
varMinus:=
varEqual:=
varBackslash:=

^+1::
send ^c
sleep 200
var1:=clipboard
return
^+2::
send ^c
sleep 200
var2:=clipboard
return
^+3::
send ^c
sleep 200
var3:=clipboard
return
^+4::
send ^c
sleep 200
var4:=clipboard
return
^+5::
send ^c
sleep 200
var5:=clipboard
return
^+6::
send ^c
sleep 200
var6:=clipboard
return
^+7::
send ^c
sleep 200
var7:=clipboard
return
^+8::
send ^c
sleep 200
var8:=clipboard
return
^+9::
send ^c
sleep 200
var9:=clipboard
return
^+0::
send ^c
sleep 200
var0:=clipboard
return
^+-::
send ^c
sleep 200
varMinus:=clipboard
return
^+=::
send ^c
sleep 200
varEqual:=clipboard
send {End}
return
^+\::
send ^c
varBackslash:=clipboard
return

;Paste the Repsective Value
^1::
send %var1%
return
^2::
send %var2%
return
^3::
send %var3%
return
^4::
send %var4%
return
^5::
send %var5%
return
^6::
send %var6%
return
^7::
send %var7%
return
^8::
send %var8%
return
^9::
send %var9%
return
^0::
send %var0%
return
^-::
send %varMinus%
return
^=::
send %varEqual%
return
^\::
send %varBackslash%
return
