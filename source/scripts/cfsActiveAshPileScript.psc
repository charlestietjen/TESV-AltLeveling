Scriptname cfsActiveAshPileScript extends Quest  

;properties
actor property playerref auto 

objectreference property cfsXPAshPileRef auto 
objectreference property cfsLevelSpaceXMarker auto

cfsspendxpmenuscript property MenuScript auto 

globalvariable property _cfsHeldXPFloatGV auto

imagespacemodifier property FadeToBlackIMOD auto

float property droppedxp auto

;events

Event OnInit()
    Registerforsingleupdate(1)
EndEvent

Event OnUpdate()
    droppedxp = _cfsHeldXPFloatGV.GetValue()
    MenuScript.IncXP(-droppedxp)
    cfsXPAshPileRef.moveto(playerref)
    cfsXPAshPileRef.enable()
    playerref.moveto(cfsLevelSpaceXMarker)
    Utility.Wait(3)
    FadeToBlackIMOD.remove()
EndEvent

Function xpRecover()
    cfsXPAshPileRef.disable()
    MenuScript.IncXP(droppedxp)
EndFunction

Function clearXP()
    droppedxp = 0
    cfsXPAshPileRef.disable()
endfunction