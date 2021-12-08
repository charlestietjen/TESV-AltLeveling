Scriptname cfsVersionUpdateScr extends ReferenceAlias  

;Maintenance script for stopping and starting quests if needed between updates

globalvariable property _cfsReleaseNumber auto

quest property _cfsAlternativeLevelQuest auto
quest property _cfsXPStatsQuest auto

leveleditem property LootGoldChange auto 
leveleditem property LootGoldChange25 auto 
leveleditem property LootGoldChange50 auto 

formlist property _cfsConsList auto

float property lastVersion auto

;push consumables into leveled lists here instead of our own drop calcs

Event OnPlayerLoadGame()
    debug.notification("playerloadgame event")
    float newVersion = _cfsReleaseNumber.GetValue()
    if newVersion <= lastVersion
        debug.notification("up to date, doing nothing")
    else
      debug.notification("updating AL")
     ;_cfsAlternativeLevelQuest.stop()
     ;_cfsXPStatsQuest.stop()
      Registerforsingleupdate(2)
      lastVersion = newVersion   
    endif 
EndEvent

Event OnUpdate()
    int i = 0
    int l = 26
    while i < _cfsConsList.GetSize()
        LootGoldChange.AddForm(_cfsConsList.GetAt(i), l, 1)
        LootGoldChange25.AddForm(_cfsConsList.GetAt(i), l, 1)
        LootGoldChange50.AddForm(_cfsConsList.GetAt(i), l, 1)
        l -= 5
        i += 1
    endwhile
    ;_cfsXPStatsQuest.start()
    ;_cfsAlternativeLevelQuest.start()
EndEvent