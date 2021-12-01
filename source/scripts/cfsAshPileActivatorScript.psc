Scriptname cfsAshPileActivatorScript extends ObjectReference  

quest property _cfsActiveAshPileQuest auto 

actor property playerref auto 


Event onactivate(objectreference a)
    if a == playerref 
        _cfsActiveAshPileQuest.setstage(10)
        _cfsActiveAshPileQuest.setobjectivecompleted(0)
        _cfsActiveAshPileQuest.stop()
    endif
endevent