scriptName cfsKillTrackerScr extends quest

;-- Properties --------------------------------------
actor property playerRef

;faction properties
faction property NecromancerFaction auto
faction property GiantFaction auto
faction property WolfFaction auto
faction property WispFaction auto
faction property HareFaction auto
faction property WarlockFaction auto
faction property HagravenFaction auto
faction property DaedraFaction auto
faction property SpiderFaction auto
faction property FoxFaction auto
faction property FalmerFaction auto
faction property ThalmorFaction auto
faction property VampireFaction auto
faction property SlaughterfishFaction auto
faction property DraugrFaction auto
faction property DremoraFaction auto
faction property PreyFaction auto
faction property TrollFaction auto
faction property IceWraithFaction auto
faction property GoatFaction auto
faction property SprigganFaction auto
faction property SilverhandFaction auto
faction property FarmAnimalsFaction auto
faction property ForswornFaction auto
faction property SkeletonFaction auto
faction property BearFaction auto
faction property VampireThrallFaction auto
faction property HorkerFaction auto
faction property BanditFaction auto
faction property DragonFaction auto
faction property DragonPriestFaction auto
faction property MammothFaction auto
faction property DwarvenAutomatonFaction auto
faction property SabreCatFaction auto
faction property ChaurusFaction auto
faction property SkeeverFaction

;keyword properties

;unique actors properties

;quest properties
quest property _cfsAlternateLevelQuest auto
quest property _cfsWidgetQuest auto
;script properties
cfsspendxpmenuscript property MenuScript

;private properties
Float property XPIncr auto hidden


;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

;calculate how much to increment XP
function XPCalc(Float fXP, Float pcL, Float vL)

	XPIncr = vL * fXP
endFunction

; Skipped compiler generated GotoState

;run when the player is responsible for a kill actor event
function OnStoryKillActor(objectreference victim, objectreference killer, Location aklocation, Int crimeStatus, Int relStatus)

	actor aVictim = victim as actor
	actor aKiller = killer as actor
	Float vL = aVictim.GetLevel() as Float
	Float pcL = aKiller.GetLevel() as Float
	self.XPCalc(grabxp(), pcL, vL)
	;Send the XP increment to the menu script
	MenuScript.IncXP(XPIncr)
	endIf
	self.stop()
endFunction

;figure out who died
function grabxp(Float gXP)
endfunction
