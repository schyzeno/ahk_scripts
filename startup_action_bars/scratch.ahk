+F11::
runPS()
sleep 1000
runPC()
return

::/pack::
runPS()
sleep 500
runPC()
return

::/ps::
runPS()
return

::/pc::
runPC()
return

runPS()
{
Send {F11}
sleep 1500
Send ps NM Packstation Server
sleep 1500
Send {LAlt Down}d{LAlt Up}
}

runPC()
{
Send {F11}
sleep 1500
Send pc NM packstation Client
sleep 1500
Send {LAlt Down}d{LAlt Up}
}