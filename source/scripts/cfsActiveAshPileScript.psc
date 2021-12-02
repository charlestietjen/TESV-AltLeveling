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
    droppedxp = _cfsHeldXPFloatGV.GetValue()
    bool track = false
    VarsScript.IncXP(-droppedxp, track)
    cfsXPAshPileRef.moveto(playerref)
    cfsXPAshPileRef.enable()
    ;debug.sendanimationevent(playerref, "BleedOutStop")
    int res = 1
    VarsScript.resorrev(res)
    playerref.moveto(cfsLevelSpaceXMarker)
    playerref.restoreactorvalue("health", 999)
    playerref.unequipitem(playerref.getequippedweapon())
    playerref.unequipitem(playerref.getequippedweapon(true))
    playerref.unequipspell(playerref.getequippedspell(0), 0)
    playerref.unequipspell(playerref.getequippedspell(1), 1)
    Utility.Wait(6)
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