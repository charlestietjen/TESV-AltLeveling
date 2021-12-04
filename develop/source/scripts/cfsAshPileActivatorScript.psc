Scriptname cfsAshPileActivatorScript extends ObjectReference  

;simple script that updates the state of the recover xp quest when the player activates their lost xp pile

quest property _cfsActiveAshPileQuest auto 

actor property playerref auto 


Event onactivate(objectreference a)
    if a == playerref 
        _cfsActiveAshPileQuest.setstage(10)
        _cfsActiveAshPileQuest.setobjectivecompleted(0)
        _cfsActiveAshPileQuest.stop()
    endif
endevent