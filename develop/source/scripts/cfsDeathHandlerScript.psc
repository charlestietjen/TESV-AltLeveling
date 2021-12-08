Scriptname cfsDeathHandlerScript extends referencealias  

;This script runs on an alias filled with the player, it's responsible for detecting each time the player changes location and for detecting when the player is in a
;bleeding out state and player death must be simulated.

;properties
objectreference property cfsReturnXMarker auto 
objectreference property cfsLevelSpaceXMarker auto 
objectreference property cfsXPAshPileRef auto

actor property playerref auto 

globalvariable property _cfsHeldXPFloatGV auto 
globalvariable property _cfsDeathCount auto

location property cfsLevelSpaceLocation auto

quest property _cfsActiveAshPileQuest auto 
quest property DGIntimidateQuest auto

musictype property cfsMUSSpecialDeath auto

imagespacemodifier property FadeToBlackIMOD auto

cfsVersionUpdateScr property UpdateScript auto

cfsAlternateLevelVarsScript property ResScript auto

bool property deathInit auto 
location property storedLoc auto

;events 

;When the player changes location and the location is both currently loaded and not the leveling hub, move an xmarker to their current position to define a respawn point
;we also clear the list of actors to resurrect each time the location is changed

Event onLocationChange(location oldL, location newL)
    if newL != storedLoc && newL != cfsLevelSpaceLocation
        storedLoc = newL
        debug.notification("location change, moving xmarker")
        cfsReturnXMarker.moveto(playerref)
        int res = 0
        ResScript.resorrev(res)
    endif
EndEvent

;when bleedout starts we check if the vanilla brawl quest is running, if not we wait for a 2 second grace period for other effects/mods.

Event OnEnterBleedout()
    if !DGIntimidateQuest.isrunning()
        playerref.pushactoraway(playerref, 1.0)
        Registerforsingleupdate(2)
    endif
EndEvent

;After the grace window we simulate the player's death, add a custom death musictype that points to the vanilla track records, make the player ragdoll and apply a fadetoblack
;we then increment the total deaths global for stat tracking, check if the xp recover quest is already running and fail/start/stop as appropriate, that quest takes over.

Event OnUpdate()
    if playerref.isbleedingout()
        ;debug.notification("still in bleedout, dying now")
        cfsMUSSpecialDeath.add()
        playerref.pushactoraway(playerref, 1.0)
        FadeToBlackIMOD.apply(1.0)
        deathSim()
    endif
EndEvent

;as a precaution to prevent music types piling up in the queue we remove our custom death music type on every load
Event OnPlayerLoadGame()
    cfsMUSSpecialDeath.remove()
EndEvent

Function deathSim()
    cfsXPAshPileRef.moveto(playerref)
    cfsXPAshPileRef.enable()
    int res = 1
    ResScript.resorrev(res)
    _cfsDeathCount.setvalue(_cfsDeathCount.getvalue() + 1)
    playerref.restoreactorvalue("health", 999)
    playerref.moveto(cfsLevelSpaceXMarker)
    playerref.unequipitem(playerref.getequippedweapon())
    playerref.unequipitem(playerref.getequippedweapon(true))
    playerref.unequipspell(playerref.getequippedspell(0), 0)
    playerref.unequipspell(playerref.getequippedspell(1), 1)
    Utility.Wait(6)
    if _cfsActiveAshPileQuest.isrunning()
        _cfsActiveAshPileQuest.setstage(20)
        _cfsActiveAshPileQuest.setobjectivefailed(0)
        _cfsActiveAshPileQuest.stop()
        _cfsActiveAshPileQuest.start()
    else
        _cfsActiveAshPileQuest.start()
    endif
EndFunction