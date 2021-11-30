Scriptname cfsDeathHandlerScript extends Actor  

;properties
objectreference property cfsReturnXMarker auto 
objectreference property cfsLevelSpaceXMarker auto 

actor property playerref auto 

globalvariable property _cfsHeldXPFloatGV auto 

location property cfsLevelSpaceLocation auto

cfsspendxpmenuscript property MenuScript auto

quest property _cfsActiveAshPileQuest auto 

musictype property cfsMUSSpecialDeath auto

imagespacemodifier property FadeToBlackIMOD auto

;events 

;xMarker mover

Event onLocationChange(location oldL, location newL)
    if newL.isloaded() && !cfsLevelSpaceLocation
        debug.notification("location change, moving xmarker")
        cfsReturnXMarker.moveto(playerref)
    endif
EndEvent

;death handling - on bleedout register for an update after 2 seconds 
;if still in bleedout then fade to black and start the quest

Event OnEnterBleedout()
    Registerforsingleupdate(2)
EndEvent

Event OnUpdate()
    if playerref.isbleedingout()
        debug.notification("still in bleedout, dying now")
        cfsMUSSpecialDeath.add()
        playerref.pushactoraway(playerref, 1.0)
        FadeToBlackIMOD.apply(1.0)
        if _cfsActiveAshPileQuest.isrunning()
            _cfsActiveAshPileQuest.setstage(20)
            _cfsActiveAshPileQuest.setobjectivefailed(2)
            _cfsActiveAshPileQuest.stop()
            _cfsActiveAshPileQuest.start()
        else
            _cfsActiveAshPileQuest.start()
            utility.wait(2)
        endif
    endif
EndEvent

Event OnPlayerLoadGame()
    cfsMUSSpecialDeath.remove()
EndEvent