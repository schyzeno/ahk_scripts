#include COM.ahk
#include VA.ahk
COM_Init()

KeyName = e
Loop {
  if GetKeyState(KeyName, "P") {
       VA_SetMasterMute(True, playback)
    
  }
  else
    VA_SetMasterMute(false, playback)
    sleep, 100
}