Scriptname cfsDeathHandlerEdgeCaseScript extends referencealias  

;This script is for handling edge cases involving our player respawn mechanic.
;It's a general purpose script that will mostly, if not entirely, simply move the respawn marker to another place when necessary.

;Potential problem list, stolen from other mods, some of these will likely have unique location info and won't be a problem.
;Halldir's Cairn, Dimhallow Cavern, Shroudhearth Barrow, Serpents Bluff, Thalmor Embassy
;Kolbjorn, Gyldenhul Barrow, Ancestor Glave, Skuldafn, Volskygge, Folgunthr, Abandoned House, Azura's Star Interior

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

;locations we have needed to edge case: kilkreath (aliased triggerbox), 