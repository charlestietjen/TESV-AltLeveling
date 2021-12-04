;/ Decompiled by Champollion V1.0.1
Source   : cfsxpmenueffectscr.psc
Modified : 2020-12-22 09:23:36
Compiled : 2020-12-28 00:52:12
User     : tietj
Computer : DESKTOP-2A7V8K9
/;
scriptName cfsxpmenueffectscr extends activemagiceffect

;-- Properties --------------------------------------
quest property cfsAlternateLevelQuest auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnEffectStart(actor t, actor c)

	cfsAlternateLevelQuest.SetStage(10)
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState
