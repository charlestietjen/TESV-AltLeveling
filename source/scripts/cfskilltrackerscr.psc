scriptName cfsKillTrackerScr extends quest

;-- Properties --------------------------------------
actor property playerRef auto

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
faction property SkeeverFaction auto

race property AlduinRace auto
race property DLC1GargoyleVariantBossRace auto
race property DLC1LD_ForgemasterRace auto
race property MagicAnomalyRace auto

actorbase property WinterholdJailFrostAtronach auto
actorbase property dunMistwatchFjola auto
actorbase property dunAnsilvundLuahAlSkaven auto
actorbase property Linwe auto
actorbase property MS06Potema auto
actorbase property MS06NecromancerLeader auto
actorbase property dunVolskyggeDragonPriest01 auto
actorbase property TitusMedeII auto
actorbase property DLC1HarkonCombat auto
actorbase property DLC1HarkonCombatMagic auto
actorbase property DLC1HarkonCombatMelee auto
actorbase property DLC1Harkon auto
actorbase property MG07LabyrinthianDragonPriest auto
actorbase property MQ104Dragon auto
actorbase property dunShearpointKrosisDragonPriest auto
actorbase property MercerFrey auto
actorbase property dunFrostmereCryptPaleLady auto
actorbase property Ianusu auto
actorbase property DLC1AlthadanVyrthur auto
actorbase property Drascua auto
actorbase property dunValthumeHevnoraak auto
actorbase property DA13Orchendor auto
actorbase property dunRagnOtar auto
actorbase property dunForelhostDragonPriestRahgot auto
actorbase property DLC2EbonyWarrior auto
actorbase property Paarthurnax auto
actorbase property EncC06WolfSpirit auto
actorbase property Ancano auto
actorbase property Karstaag auto
actorbase property DLC2SV01DragonPriestBoss auto
actorbase property DLC2dunHaknir auto
actorbase property DLC2AcolyteAhzidal auto
actorbase property DLC2AcolyteZahkriisos auto
actorbase property DLC2AcolyteDukaan auto 


;keyword properties

;unique actors properties

;quest properties
quest property _cfsAlternateLevelQuest auto
quest property _cfsWidgetQuest auto
;script properties
cfsspendxpmenuscript property MenuScript auto

;private properties
Float property XPIncr auto hidden
Float property gXP auto hidden


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
	self.XPCalc(gXP, pcL, vL)
	;Send the XP increment to the menu script
	MenuScript.IncXP(XPIncr)
	self.stop()
endFunction

;figure out who died
function grabxp(objectreference k)

endfunction
