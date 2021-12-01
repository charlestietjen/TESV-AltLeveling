Scriptname cfsVersionUpdateScr extends ReferenceAlias  

globalvariable property _cfsReleaseNumber auto

quest property _cfsAlternativeLevelQuest auto

float property lastVersion auto

Event OnPlayerLoadGame()
    debug.notification("playerloadgame event")
    float newVersion = _cfsReleaseNumber.GetValue()
    if newVersion <= lastVersion
        debug.notification("up to date, doing nothing")
        return
    endif
    debug.notification("updating AL")
    ;_cfsAlternativeLevelQuest.stop()
    Registerforsingleupdate(2)
    lastVersion = newVersion    
EndEvent

Event OnUpdate()
    ;_cfsAlternativeLevelQuest.start()
EndEvent