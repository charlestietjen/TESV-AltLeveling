scriptName cfsKillTrackerScr extends quest

;This script is a kill actor story quest script that is called when the player is responsible for killing a valid XP target.

;-- Properties --------------------------------------
actor property playerRef auto

LocationRefType property Boss auto

;Faction formlist tierlist - personal reference (subjective, obvi)

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
Formlist property consumableList auto

; This formlist will be checked first to award xp that would be inappropriate when picked up by faction (unique actors, leveled bosses etc.)
Formlist property _cfsCaseByCase auto

int[] property XPTable auto

Int property sXP = 1000 auto
Int property aXP = 500 auto
Int property bXP = 150 auto
Int property cXP = 50 auto
Int property dXP = 30 auto
Int property eXP = 10 auto

;quest properties
quest property _cfsAlternateLevelQuest auto
quest property _cfsWidgetQuest auto
;script properties
cfsAlternateLevelVarsScript property VarsScript auto

;private properties
Float property XPIncr auto hidden
Float property gXP auto hidden

;recalculate xp based on level multipliers. Under level 10 results in base xp rewards. Starting at level 10 we use player level and victim level to determine a multiplier for xp
;higher player levels give a larger boost, hopefully keeping pace w/skyrim's leveled world behavior 
function XPCalc(Float fXP, Float pcL, Float vL)
	if pcL >= 10
		XPIncr = ((pcL / 10) + (vL / 10)) * XPIncr
	else
		XPIncr = (1 + (vL /10)) * XPIncr ;Apply the scaling for level 10 statically across 1-9 to allow xp rewards to still scale with challenge
	endif
endFunction

;in the below, run a new formlist of consumables indexed to match tier lists, run a math.random to randomly place a consumable on the body

;run when the player is responsible for a kill actor event
function OnStoryKillActor(objectreference victim, objectreference killer, Location aklocation, Int crimeStatus, Int relStatus)
	actor vic = victim as actor
	;debug.notification("killed" + vic)
	XPIncr = 0
	grabxp(vic)
	XPCalc(0, playerref.getlevel(), vic.getlevel())
	;Send the XP increment to the main vars script with tracking set to true
	;Debug.Notification("Enemy: " + vic + "Level: " + vic.getlevel() + "XP: " + XPIncr)
	Debug.Trace("CFSAL: Enemy: " + vic + "Level: " + vic.getlevel() + "XP: " + XPIncr + "Player level: " + playerref.getlevel())
	bool track = true
	VarsScript.IncXP(XPIncr, track)
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
			XPIncr = XPTable[i] ;this case by case handling requires matching the order of the formlists 1:1 in the editor
		endif
	EndWhile
	;if XPIncr == 0 ;don't bother if we've already assigned an xp value
		Faction vFaction = none
		formlist[] fList = new formlist[6] ;make a new formlist and populate it with our tiered formlists
		fList[0] = _cfsSTierList
		fList[1] = _cfsATierList
		fList[2] = _cfsBTierList
		fList[3] = _cfsCTierList
		fList[4] = _cfsDTierList
		fList[5] = _cfsETierList
		int[] xpArray = new int[6] ;make a new array and populate it with our xp values
		xpArray[0] = sXP
		xpArray[1] = aXP
		xpArray[2] = bXP
		xpArray[3] = cXP
		xpArray[4] = dXP
		xpArray[5] = eXP
		i = fList.Length
	;endif
	while i && XPIncr == 0 ;run through each of our tiers from S to E until a match is found then set the xp reward appropriately
		i -= 1
		int j = fList[i].GetSize()
		while j && XPIncr == 0
			j -= 1
			vFaction = fList[i].GetAt(j) as Faction
			if k.isinfaction(vFaction)
				XPIncr = xpArray[i]
				;float droll = utility.randomfloat()
				;float dc = (5.0 - i) / 10
				;if dc < droll 
				;	debug.notification("Consumable Rolled successfully")
				;	k.AddItem(consumableList.Getat(i))
				;endif
			endif
		endwhile
	EndWhile
	if XPIncr == 0 ;if the xp reward is still zero then we could not detect what the npc was, assign a default D tier to the kill and notify the player ()
		debug.notification("Unregistered kill detected, actor's name: " + k.getname()) ;Only for QA debug, edge case xp assignment will remain but notification removed on release
		XPIncr = dXP
	endif
endfunction
