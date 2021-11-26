scriptName cfsKillTrackerScr extends quest

;-- Properties --------------------------------------
actor property playerRef auto

;Faction formlist tierlist
;E: Prey Fox Hare Goat Farmanimals horker skeever
;D: Wolf Slaughterfish Silverhand Skeleton vampirethrall bandit 
;C: Necromancer Warlock Wisp Spider Thalmor Ice Wraith Forsworn Draugr
;B: Vampire Spriggan Bear Dwarven Sabrecat Daedra Falmer Chaurus
;A: Hagraven Dremora Troll Werewolf Mammoth
;S: Giant Dragon Dragonpriest

Formlist property _cfsETierList auto ;base xp 1
Formlist property _cfsDTierList auto ;base xp 30
Formlist property _cfsCTierList auto ;base xp 50
Formlist property _cfsBTierList auto ;base xp 150
Formlist property _cfsATierList auto ;base xp 500
Formlist property _cfsSTierList auto ;base xp 1000

; This formlist will be checked first, we'll use this initially to assign reasonable experience values to actors with underwhelming level adjustments, Mercer Frey for example.
;Post 1.0 we'll use this list to award specific experience values but also to push unique rewards to the players inventory
Formlist property _cfsCaseByCase auto

;this list is purely for my own reference for 'boss' type skyrim actors, script will only utilize formlists in functions
;actorbase property WinterholdJailFrostAtronach auto
;actorbase property dunMistwatchFjola auto
;actorbase property dunAnsilvundLuahAlSkaven auto
;actorbase property Linwe auto
;actorbase property MS06Potema auto
;actorbase property MS06NecromancerLeader auto
;actorbase property dunVolskyggeDragonPriest01 auto
;actorbase property TitusMedeII auto
;actorbase property DLC1HarkonCombat auto
;actorbase property DLC1HarkonCombatMagic auto
;actorbase property DLC1HarkonCombatMelee auto
;actorbase property DLC1Harkon auto
;actorbase property MG07LabyrinthianDragonPriest auto
;actorbase property MQ104Dragon auto
;actorbase property dunShearpointKrosisDragonPriest auto
;actorbase property MercerFrey auto
;actorbase property dunFrostmereCryptPaleLady auto
;actorbase property Ianusu auto
;actorbase property DLC1AlthadanVyrthur auto
;actorbase property Drascua auto
;actorbase property dunValthumeHevnoraak auto
;actorbase property DA13Orchendor auto
;actorbase property dunRagnOtar auto
;actorbase property dunForelhostDragonPriestRahgot auto
;actorbase property DLC2EbonyWarrior auto
;actorbase property Paarthurnax auto
;actorbase property EncC06WolfSpirit auto
;actorbase property Ancano auto
;actorbase property Karstaag auto
;actorbase property DLC2SV01DragonPriestBoss auto
;actorbase property DLC2dunHaknir auto
;actorbase property DLC2AcolyteAhzidal auto
;actorbase property DLC2AcolyteZahkriisos auto
;actorbase property DLC2AcolyteDukaan auto

Int property sXP = 1000 auto
Int property aXP = 500 auto
Int property bXP = 150 auto
Int property cXP = 50 auto
Int property dXP = 30 auto
Int property eXP = 1 auto

;quest properties
quest property _cfsAlternateLevelQuest auto
quest property _cfsWidgetQuest auto
;script properties
cfsspendxpmenuscript property MenuScript auto

;private properties
Float property XPIncr auto hidden
Float property gXP auto hidden

;calculate how much to increment XP, we simply multiply the XPIncr value at this point defined by grabxp function and math it to another value
function XPCalc(Float fXP, Float pcL, Float vL)
	XPIncr = ((vL / 5) + 1) * XPIncr
	;debug.notification("Awarded: " + XPIncr)
endFunction

;run when the player is responsible for a kill actor event
function OnStoryKillActor(objectreference victim, objectreference killer, Location aklocation, Int crimeStatus, Int relStatus)
	actor vic = victim as actor
	;debug.notification("killed" + vic)
	XPIncr = 0
	grabxp(vic)
	XPCalc(0, playerref.getlevel(), vic.getlevel())
	;Send the XP increment to the menu script
	MenuScript.IncXP(XPIncr)
	self.stop()
endFunction

;faction[] fList = new faction[2]
;fList[0] = _cfsSTierList
;fList[1] = _cfsATierList
;int[] xpArray = new int[2]
;xpArray[0] = 1000
;xpArray[1] = 800
;i = fList.GetSize()
;while i 
;	i -= 1
;	j = fList[i].GetSize()
;	vFaction = fList[i].GetAt(j) as Faction
;	if k.isinfaction(vFaction)
;		XPIncr = xpArray[i]
;	endif
;EndWhile

;figure out who died
function grabxp(actor k) ;
	Int i = _cfsCaseByCase.GetSize() ;store the size of the first formlist 
	;debug.notification("grabxpfunction ran")
	While i && XPIncr == 0
		i -= 1
		actorbase uactor = _cfsCaseByCase.GetAt(i) As Actorbase 
		if k.getactorbase() == uactor
			;debug.notification("grabxp: caught a case by case, should see no other gxp function notifications")
			XPIncr = 500 ;awardxp, placeholder, final xp awards for case by case should be stored in an array where index matches appropriate formlist index entries
		endif
	EndWhile
	Faction vFaction = none
	formlist[] fList = new formlist[6]
  	fList[0] = _cfsSTierList
	fList[1] = _cfsATierList
	fList[2] = _cfsBTierList
	fList[3] = _cfsCTierList
	fList[4] = _cfsDTierList
	fList[5] = _cfsETierList
	int[] xpArray = new int[6]
	xpArray[0] = sXP
	xpArray[1] = aXP
	xpArray[2] = bXP
	xpArray[3] = cXP
	xpArray[4] = dXP
	xpArray[5] = eXP
	i = fList.Length
	while i && XPIncr == 0
		;Debug.notification("grabxp: is running through fList array")
		i -= 1
		int j = fList[i].GetSize()
		while j && XPIncr == 0
			j -= 1
			vFaction = fList[i].GetAt(j) as Faction
			if k.isinfaction(vFaction)
				;Debug.notification("grabxp: found a match in formlist, faction killed: " + vFaction)
				XPIncr = xpArray[i]
			endif
		endwhile
	EndWhile
	if XPIncr == 0
		debug.notification("unregistered kill detected")
		XPIncr = dXP
	endif
;	While i && XPIncr == 0
;		i -= 1
;		actorbase uactor = _cfsCaseByCase.GetAt(i) As Actorbase 
;		if k.getactorbase() == uactor
;			XPIncr = 500 ;awardxp, placeholder, final xp awards for case by case should be stored in an array where index matches appropriate formlist index entries
;		endif
;	EndWhile
;	i = _cfsSTierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsSTierList.GetAt(i) as Faction 
;		if k.isinfaction(vFaction)
;			XPIncr = 1000;awardxp
;		endif 
;	endwhile
;	i = _cfsATierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsATierList.GetAt(i) as faction 
;		if k.isinfaction(vFaction)
;			XPIncr = 500 ;awardxp
;		endif
;	endwhile
;	i = _cfsBTierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsBTierList.GetAt(i) as faction 
;		if k.isinfaction(vFaction)
;			XPIncr = 150 ;awardxp
;		endif
;	endwhile 
;	i = _cfsCTierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsCTierList.GetAt(i) as faction 
;		if k.isinfaction(vFaction)
;			XPIncr = 50 ;awardxp
;		endif 
;	endwhile 
;	i = _cfsDTierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsDTierList.GetAt(i) as faction
;		if k.isinfaction(vFaction)
;			XPIncr = 30 ;awardxp
;		endif 
;	endwhile
;	i = _cfsETierList.GetSize()
;	While i && XPIncr == 0
;		i -= 1
;		vFaction = _cfsETierList.GetAt(i) as faction
;		if k.isinfaction(vFaction)
;			XPIncr = 1 ;awardxp
;		endif 
;	endwhile
;	if XPIncr == 0
;		XPIncr = 150 ;awardXP
;	endif
endfunction
