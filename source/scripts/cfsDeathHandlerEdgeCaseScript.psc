Scriptname cfsDeathHandlerEdgeCaseScript extends referencealias  

;properties
actor property playerref auto 

objectreference property cfsReturnXMarker auto

;events

Event onTriggerEnter(objectreference e)
    if e == playerref
        debug.notification("edge case mode activate!")
        cfsReturnXMarker.moveto(playerref)
    endif
endevent