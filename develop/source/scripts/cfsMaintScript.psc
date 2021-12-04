Scriptname cfsMaintScript extends Quest  

Float fVersion
Int iSKSE
GlobalVariable Property cfsRunningSKSE  Auto
globalvariable property _cfsReleaseNumber auto
;fill this property
Quest Property statQuest  Auto
;fill this property
 
Event OnInit()
     Maintenance() ; OnPlayerLoadGame will not fire the first time
EndEvent
 
Function Maintenance()
     If fVersion < 1.00 ; edit this value for each new version of your mod - i.e. version 1.1 ;would have 1.1.0 here
          fVersion = 1.00 ; and edit this value to the version number of your mod
          ; Update Code - do any updating code (under script versioning on that page)
     EndIf
     iSKSE = SKSE.GetVersionRelease()
     If iSKSE
          ;SKSE installed
          If runningSKSE.GetValueInt() == 0
               runningSKSE.SetValueInt(1)
               statQuest.Start()
          EndIf
     Else
          If runningSKSE.GetValueInt() == 1
               runningSKSE.SetValueInt(0)
               statQuest.Stop()
          EndIf
     EndIf
EndFunction