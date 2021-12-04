Scriptname cfsVersionUpdateScr extends ReferenceAlias  

;Maintenance script for stopping and starting quests if needed between updates

globalvariable property _cfsReleaseNumber auto

quest property _cfsAlternativeLevelQuest auto
quest property _cfsXPStatsQuest auto

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
    _cfsXPStatsQuest.stop()
    Registerforsingleupdate(2)
    lastVersion = newVersion    
EndEvent

Event OnUpdate()
    _cfsXPStatsQuest.start()
    ;_cfsAlternativeLevelQuest.start()
EndEvent