Scriptname cfsDeathHandlerScript extends referencealias  

;properties
objectreference property cfsReturnXMarker auto 
objectreference property cfsLevelSpaceXMarker auto 

actor property playerref auto 

globalvariable property _cfsHeldXPFloatGV auto 
globalvariable property _cfsDeathCount auto

location property cfsLevelSpaceLocation auto

quest property _cfsActiveAshPileQuest auto 

musictype property cfsMUSSpecialDeath auto

imagespacemodifier property FadeToBlackIMOD auto

cfsVersionUpdateScr property UpdateScript auto

cfsAlternateLevelVarsScript property ResScript auto

bool property deathInit auto 

;events 

;xMarker mover

Event OnInit()
    debug.notification("death handling script initialized")
EndEvent

Event onLocationChange(location oldL, location newL)
    if newL.isloaded() && newL != cfsLevelSpaceLocation
        debug.notification("location change, moving xmarker")
        cfsReturnXMarker.moveto(playerref)
        ResScript.resorrev(0)
    endif
EndEvent

;death handling - on bleedout register for an update after 2 seconds 
;if still in bleedout then fade to black and start the quest

Event OnEnterBleedout()
    Registerforsingleupdate(2)
EndEvent

Event OnUpdate()
    if playerref.isbleedingout()
        ;debug.notification("still in bleedout, dying now")
        cfsMUSSpecialDeath.add()
        playerref.pushactoraway(playerref, 1.0)
        FadeToBlackIMOD.apply(1.0)
        _cfsDeathCount.setvalue(_cfsDeathCount.getvalue() + 1)
        if _cfsActiveAshPileQuest.isrunning()
            _cfsActiveAshPileQuest.setstage(20)
            _cfsActiveAshPileQuest.setobjectivefailed(0)
            _cfsActiveAshPileQuest.stop()
            _cfsActiveAshPileQuest.start()
            Utility.Wait(6)
            ResScript.resorrev(1)
        else
            _cfsActiveAshPileQuest.start()
        endif
    endif
EndEvent

Event OnPlayerLoadGame()
    cfsMUSSpecialDeath.remove()
EndEvent