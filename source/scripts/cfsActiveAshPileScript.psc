Scriptname cfsActiveAshPileScript extends Quest  

;properties
actor property playerref auto 

objectreference property cfsXPAshPileRef auto 
objectreference property cfsLevelSpaceXMarker auto

cfsAlternateLevelVarsScript property VarsScript auto 

globalvariable property _cfsLifetimeXPLost auto
globalvariable property _cfsHeldXPFloatGV auto

imagespacemodifier property FadeToBlackIMOD auto

float property droppedxp auto

;events

Function dropxp()
    debug.notification("dropxp called")
    droppedxp = _cfsHeldXPFloatGV.GetValue()
    VarsScript.IncXP(-droppedxp, true)
    cfsXPAshPileRef.moveto(playerref)
    cfsXPAshPileRef.enable()
    debug.sendanimationevent(playerref, "BleedOutStop")
    playerref.restoreactorvalue("health", 999)
    playerref.moveto(cfsLevelSpaceXMarker)
    Utility.Wait(6)
    FadeToBlackIMOD.remove()
EndFunction

Function xpRecover()
    debug.notification("xprecover called")
    cfsXPAshPileRef.disable()
    VarsScript.IncXP(droppedxp, true)
EndFunction

Function clearXP()
    debug.notification("clearxp called")
    _cfsLifetimeXPLost.SetValue(_cfsLifetimeXPLost.GetValue() + droppedxp)
    droppedxp = 0
    cfsXPAshPileRef.disable()
endfunction