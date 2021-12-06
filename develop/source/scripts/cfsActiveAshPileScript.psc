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
    droppedxp = 0
    debug.notification("dropxp called")
    cfsXPAshPileRef.enable()
    droppedxp = _cfsHeldXPFloatGV.GetValue()
    bool track = false
    playerref.pushactoraway(playerref, 1.0)
    VarsScript.IncXP(-droppedxp, track)
    FadeToBlackIMOD.remove()
EndFunction

Function xpRecover()
    debug.notification("xprecover called")
    cfsXPAshPileRef.disable()
    bool track = false
    VarsScript.IncXP(droppedxp, track)
    droppedxp = 0
EndFunction

Function clearXP()
    debug.notification("clearxp called")
    _cfsLifetimeXPLost.SetValue(_cfsLifetimeXPLost.GetValue() + droppedxp)
    droppedxp = 0
    cfsXPAshPileRef.disable()
endfunction