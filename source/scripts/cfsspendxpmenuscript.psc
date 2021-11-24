scriptName cfsspendxpmenuscript extends Quest

;-- Properties --------------------------------------
message property cfsLevelMenuCombat auto
cfsxpwidgetcore property WC auto
Float property cfshStatCost auto
Quest property _cfsWidgetQuest auto
message property cfsLevelMenuStealth auto
sound property cfsxpacquire auto
spell property _cfsSkillGainKillerAb auto
Float property cfsHeldExperience auto
actor property playerRef auto
message property cfsLevelMenuRoot auto
message property cfsLevelMenuMagic auto
message property _cfsLevelMenuSumm1 auto
globalvariable property _cfsHeldXPFloatGV auto
message property _cfsLevelMenuSumm3 auto
message property cfsLevelMenuNope auto
message property _cfsLevelMenuSumm2 auto

;-- Variables ---------------------------------------
int property _tempSCost auto hidden
int property _tempExp auto hidden
;-- Functions ---------------------------------------

function IncXP(Float xpValue)

	Float heldxp = _cfsHeldXPFloatGV.GetValue()
	_cfsHeldXPFloatGV.SetValue(_cfsHeldXPFloatGV.GetValue() + xpValue)
	WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
endFunction

;Menu Function

;rewrite for new refactor and new formula

function SpendXPMenu(Int aiMessage, Int aiB, Bool abMenu) ;aiMessage is the message box var, aiB is the var for menu choices, abMenu bool for menu is open
	;disable controls then enable (I don't remember why we do this, it's in the messagebox menu tutorial i think)
	game.DisablePlayerControls(false, false, false, false, false, true, true, false, 0)
	game.EnablePlayerControls(false, false, false, false, false, true, true, true, 0)
	;store the current xp global in a menu only variable, this is for allowing the player to back out and not have to do a bunch of setting etc.
	_tempExp = _cfsHeldXPFloatGV.GetValue()
	_tempSCost = 0 ;reset the temporary skill cost increase variable
	StatCost() ;run the skillcost function to display accurate cost on root menu
	;A smarter dev would probably do these ints in an array but...i'm not smart
	Int archInc = 0
	Int blocInc = 0
	Int harmInc = 0
	Int onehInc = 0
	Int smithInc = 0
	Int twohInc = 0
	Int alteInc = 0
	Int conjInc = 0
	Int destInc = 0
	Int enchInc = 0
	Int illuInc = 0
	Int restInc = 0
	Int alchInc = 0
	Int larmInc = 0
	Int lockinc = 0
	Int pickInc = 0
	Int sneaInc = 0
	Int speeInc = 0
	;remove the 0 skill xp multiplier ability from the player
	playerRef.RemoveSpell(_cfsSkillGainKillerAb)
	;While the menu bool is true open the Menu
	While abMenu
		if aiB != -1 ;Catch the int somehow dropping below 0
			if aiMessage == 0 ;root Menu
				aiB = cfsLevelMenuRoot.show(tempExp, cfshStatCost) ;show the root menu and supply the tempExp and statCost variables, also this other stuff?
				if aiB == 0 ;combat options
					aiMessage = 1
				elseif aiB == 1 ;magic options
					aiMessage = 2
				elseif aiB == 2 ;stealth options
					aiMessage = 3
				elseif aiB == 3 ;tbd
				elseif aiB == 4 ;Summary
					aiMessage = 5
				elseif aiB == 6 ;Debug give xp
					_cfsHeldXPFloatGV.SetValue(_cfsHeldXPFloatGV() + 100.0)
					WC.UpdateWidget(_cfsHeldXPFloatGV() as Int)
					playerRef.AddSpell(_cfsSkillGainKillerAb, false)
				else
					abMenu = false
					playerRef.AddSpell(_cfsSkillGainKillerAb, false)
			elseif aiMessage == 1 ;Combat options Menu, show the combat menu and send it the tempExp, Stat cost and current increment values per combat skill
				_cfsLevelMenuCombat.show(_tempExp, cfshStatCost, archInc as float, blocInc as float, harmInc as float, onehInc as float, smithInc as float, twohInc as float)
				if aiB == 0 && _tempExp >= cfshStatCost ;archery
					archInc += 1 ;increase the increment variable for later commit
					stXP() ;reduce remaining tempXP and add a simulated step to stat cost formula
					statCost() ;recalculate stat cost
				ElseIf == 1 && _tempExp >= cfshStatCost ;block
					blocInc += 1
					stXP()
					statCost()
				ElseIf == 2 && _tempExp >= cfshStatCost ;heavy armor
					harmInc += 1
					stXP()
					statCost()
				ElseIf == 3 && _tempExp >= cfshStatCost ;two handed
					twohInc += 1
					stXP()
					statCost()
				ElseIf == 4 && _tempExp >= cfshStatCost ;one handed
					onehInc += 1
					stXP()
					statCost()
				ElseIf == 5 && _tempExp >= cfshStatCost ;smithing
					smithInc += 1
					stXP()
					statCost()
				elseif == 6 ;back
					aiMessage = 0
				else
					aiMessage = 8 ;insufficient experience
				endIf
			elseif aiMessage == 2 ;Magic options menu
				_cfsLevelMenuMagic.show(_tempExp, cfshStatCost, altInc as float, conjInc as float, destInc as float, enchInc as float, illuInc as float, restInc as float)
				if aiB == 0 && _tempExp >= cfshStatCost ;alteration
					altInc += 1
					stXP()
					statCost()
				elseif aib == 1 && _tempExp >= cfshStatCost ;conjuration
					conjInc += 1
					stXP()
					statCost()
				elseif aiB == 2 && _tempExp >= cfshStatCost ;destruction
					destInc += 1
					stXP()
					statCost()
				elseif aiB == 3 && _tempExp >= cfshStatCost ;Enchanting
					enchInc += 1
					stXP()
					statCost()
				elseif aiB == 4 && _tempExp >= cfshStatCost ;illusion
					illuInc += 1
					stXP()
					statCost()
				elseif aiB == 5 && _tempExp >= cfshStatCost ;Restoration
					restInc += 1
					stXP()
					statCost()
				elseif == 6 ;back
					aiMessage = 0
				else
					aiMessage = 8 ;insufficient experience
				endIf
			elseif aiMessage == 3 ;Stealth menu
				_cfsLevelMenuStealth.show(_tempExp, cfshStatCost, alchInc as float, larmInc as float, lockinc as float, pickInc as float, sneaInc as float, speeInc as float)
				if aiB == 0 && _tempExp >= cfshStatCost ;alchemy
					alchInc += 1
					stXP()
					StatCost()
				elseif aiB == 1 && _tempExp >= cfshStatCost ;light armor
					larmInc += 1
					stXP()
					statCost()
				elseif aiB == 2 && _tempExp >= cfshStatCost ;lockpick
					lockinc += 1
					stXP()
					statCost()
				elseif aiB == 3 && _tempExp >= cfshStatCost ;pickpocket
					pickInc += 1
					stXP()
					statCost()
				elseif aiB == 4 && _tempExp >= cfshStatCost ;sneaking
					sneaInc += 1
					stXP()
					statCost()
				elseif aiB == 5 && _tempExp >= cfshStatCost ;speech
					speeInc += 1
					stXP()
					statCost()
				elseif == 6 ;back
					aiMessage = 0
				else
					aiMessage = 8 ;insufficient experience
			elseif aiMessage == 5 ;summary
				_cfsLevelMenuSumm1.show(archInc as float, blocInc as float, harmInc as float, onehInc as float, smithInc as float, twohInc as float) ;Combat summary, display all selected skill increments
				if aiB == 0 ;confirm
					aiMessage = 9
				elseif aiB == 1 ;Back
					aiMessage = 0
				elseif aiB == 2 ;Magic Summary
					aiMessage = 6
				elseif aiB == 3 ;Stealth Summary
					aiMessage = 7
				endIf
			elseif aiMessage == 6
				_cfsLevelMenuSumm2.show(altInc as float, conjInc as float, destInc as float, enchInc as float, illuInc as float, restInc as float) ;Magic summary
				if aiB == 0 ;confirm
					aiMessage = 9
				elseif aiB == 1 ;back
					aiMessage = 0
				elseif aiB == 2 ;Combat
					aiMessage = 5
				elseif aiB == 3 ;Stealth
					aiMessage = 7
			elseif aiMessage == 7
				_cfsLevelMenuSumm3.show(alchInc as float, larmInc as float, lockinc as float, pickInc as float, sneaInc as float, speeInc as float)
				if aiB == 0 ;confirm
					aiMessage = 9
				elseif aiB == 1 ;back
					aiMessage = 0
				elseif aiB == 2 ;combat
				 	aiMessage = 5
				elseif aiB == 3 ;magic
					aiMessage = 6
			elseif aiMessage == 9 ;commit changes by increments and close out
			elseIf aiMessage == 8
				if archInc != 0
					game.incrementskillby("marksman", archInc)
				endIf
				if blocInc != 0
					game.incrementskillby("block", blocInc)
				endIf
				if harmInc != 0
					game.incrementskillby("HeavyArmor", harmInc)
				endIf
				if onehInc != 0
					game.incrementskillby("onehanded", onehInc)
				endIf
				if smithInc != 0
					game.incrementskillby("smithing", smithInc)
				endIf
				if twohInc != 0
					game.incrementskillby("twohanded", twohInc)
				endIf
				if alteInc != 0
					game.incrementskillby("alteration", alteInc)
				endIf
				if conjInc != 0
					game.incrementskillby("conjuration", conjInc)
				endIf
				if destInc != 0
					game.incrementskillby("destruction", destInc)
				endIf
				if enchInc != 0
					game.incrementskillby("enchanting", enchInc)
				endIf
				if illuInc != 0
					game.incrementskillby("illusion", illuInc)
				endIf
				if restInc != 0
					game.incrementskillby("restoration", restInc)
				endIf
				if alchInc != 0
					game.incrementskillby("alchemy", alchInc)
				endIf
				if larmInc != 0
					game.incrementskillby("lightarmor", larmInc)
				endIf
				if lockinc != 0
					game.incrementskillby("lockpicking", lockinc)
				endIf
				if pickInc != 0
					game.incrementskillby("pickpocket", pickInc)
				endIf
				if sneaInc != 0
					game.incrementskillby("sneak", sneaInc)
				endIf
				if speeInc != 0
					game.incrementskillby("speechcraft", speeInc)
				endIf
				playerRef.AddSpell(_cfsSkillGainKillerAb, false)
				_cfsHeldXPFloatGV.SetValue(_tempExp)
				WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
				abMenu = false
			else
				aiMessage = 0
			endif
		endIf
	endWhile
endFunction

Function stXP()
	_tempExp -= cfshStatCost
	_tempSCost += 1
endFunction

Function statCost() ;add all current skill values/temporary cost increaser and do math
	Int _arch = playerref.GetBaseAV("Marksman")
	Int _bloc = playerref.GetBaseAV("Block")
	Int _harm = playerref.GetBaseAV("HeavyArmor")
	Int _oneh = playerref.GetBaseAV("OneHanded")
	Int _smit = playerref.GetBaseAV("Smithing")
	Int _twoh = playerref.GetBaseAV("TwoHanded")
	Int _alte = playerref.GetBaseAV("Alteration")
	Int _conj = playerref.GetBaseAV("Conjuration")
	Int _dest = playerref.GetBaseAV("Destruction")
	Int _ench = playerref.GetBaseAV("Enchanting")
	Int _illu = playerref.GetBaseAV("Illusion")
	Int _rest = playerref.GetBaseAV("Restoration")
	Int _alch = playerref.GetBaseAV("Alchemy")
	Int _larm = playerref.GetBaseAV("LightArmor")
	Int _lock = playerref.GetBaseAV("Lockpicking")
	Int _pick = playerref.GetBaseAV("Pickpocket")
	Int _snea = playerref.GetBaseAV("Sneak")
	Int _spee = playerref.GetBaseAV("Speechcraft")
	cfshStatCost = ((_arch + _bloc + _harm + _oneh + _smit + _twoh + _alte + _conj + _dest + _ench + _illu + _rest + _alch + _larm + _lock + _pick + _snea + _spee + _tempSCost) / 20) ^2
EndFunction
