scriptName cfsKillTrackerScr extends quest

;-- Properties --------------------------------------
actor property playerRef auto

LocationRefType property Boss auto

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

; This formlist will be checked first to award xp that would be inappropriate when picked up by faction (unique actors, leveled bosses etc.)
Formlist property _cfsCaseByCase auto

int[] property XPTable auto

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

;recalculate xp based on level multipliers. Under level 5 results in base xp rewards. Starting at level 5 we use player level and victim level to determine a multiplier for xp
;higher player levels give a larger boost, hopefully keeping pace w/skyrim's leveled world behavior 
function XPCalc(Float fXP, Float pcL, Float vL)
	if pcL > 5
		XPIncr = ((pcL / 5) + (vL / 10)) * XPIncr
	endif
endFunction

;run when the player is responsible for a kill actor event
function OnStoryKillActor(objectreference victim, objectreference killer, Location aklocation, Int crimeStatus, Int relStatus)
	actor vic = victim as actor
	;debug.notification("killed" + vic)
	XPIncr = 0
	grabxp(vic)
	XPCalc(0, playerref.getlevel(), vic.getlevel())
	;Send the XP increment to the menu script
	Debug.Notification("Enemy: " + vic + "Level: " + vic.getlevel() + "XP: " + XPIncr)
	Debug.Trace("CFSAL: Enemy: " + vic + "Level: " + vic.getlevel() + "XP: " + XPIncr + "Player level: " + playerref.getlevel())
	MenuScript.IncXP(XPIncr)
	self.stop()
endFunction

;figure out who died
function grabxp(actor k) ;
	Int i = _cfsCaseByCase.GetSize() ;store the size of the first formlist 
	;debug.notification("grabxpfunction ran")
	While i && XPIncr == 0
		i -= 1
		actorbase uactor = _cfsCaseByCase.GetAt(i) As Actorbase 
		if k.getactorbase() == uactor
			XPIncr = XPTable[i]
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
endfunction