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

;-- Functions ---------------------------------------

function IncXP(Float xpValue)

	Float heldxp = _cfsHeldXPFloatGV.GetValue()
	_cfsHeldXPFloatGV.SetValue(_cfsHeldXPFloatGV.GetValue() + xpValue)
	WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
endFunction

; Skipped compiler generated GetState

function SpendXPMenu(Int aiMessage, Int aiB, Bool abMenu)

	game.DisablePlayerControls(false, false, false, false, false, true, true, false, 0)
	game.EnablePlayerControls(false, false, false, false, false, true, true, true, 0)
	Float tempExp = _cfsHeldXPFloatGV.GetValue()
	Float statCost = cfshStatCost
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
	playerRef.RemoveSpell(_cfsSkillGainKillerAb)
	while abMenu
		if aiB != -1
			if aiMessage == 0
				aiB = cfsLevelMenuRoot.show(tempExp, statCost, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				if aiB == 0
					aiMessage = 1
				elseIf aiB == 1
					aiMessage = 2
				elseIf aiB == 2
					aiMessage = 3
				elseIf aiB == 3

				elseIf aiB == 4
					aiMessage = 5
				elseIf aiB == 6
					_cfsHeldXPFloatGV.SetValue(_cfsHeldXPFloatGV.GetValue() + 100 as Float)
					WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
					playerRef.AddSpell(_cfsSkillGainKillerAb, false)
				else
					abMenu = false
					playerRef.AddSpell(_cfsSkillGainKillerAb, false)
				endIf
			elseIf aiMessage == 1
				aiB = cfsLevelMenuCombat.show(tempExp, statCost, archInc as Float, blocInc as Float, harmInc as Float, onehInc as Float, smithInc as Float, twohInc as Float, 0.000000)
				if aiB == 0 && tempExp >= statCost
					archInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 1 && tempExp >= statCost
					blocInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 2 && tempExp >= statCost
					harmInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 3 && tempExp >= statCost
					onehInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 4 && tempExp >= statCost
					smithInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 5 && tempExp >= statCost
					twohInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 6
					aiMessage = 0
				else
					aiMessage = 4
				endIf
			elseIf aiMessage == 2
				aiB = cfsLevelMenuMagic.show(tempExp, statCost, alteInc as Float, conjInc as Float, destInc as Float, enchInc as Float, illuInc as Float, restInc as Float, 0.000000)
				if aiB == 0 && tempExp >= statCost
					alteInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 1 && tempExp >= statCost
					conjInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 2 && tempExp >= statCost
					destInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 3 && tempExp >= statCost
					enchInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 4 && tempExp >= statCost
					illuInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 5 && tempExp >= statCost
					restInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 6
					aiMessage = 0
				else
					aiMessage = 4
				endIf
			elseIf aiMessage == 3
				aiB = cfsLevelMenuStealth.show(tempExp, statCost, alchInc as Float, larmInc as Float, lockinc as Float, pickInc as Float, sneaInc as Float, speeInc as Float, 0.000000)
				if aiB == 0 && tempExp >= statCost
					alchInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 1 && tempExp >= statCost
					larmInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 2 && tempExp >= statCost
					lockinc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 3 && tempExp >= statCost
					pickInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 4 && tempExp >= statCost
					sneaInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 5 && tempExp >= statCost
					speeInc += 1
					tempExp -= statCost
					statCost *= 1.12000
				elseIf aiB == 6
					aiMessage = 0
				else
					aiMessage = 4
				endIf
			elseIf aiMessage == 4
				cfsLevelMenuNope.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				aiMessage = 0
			elseIf aiMessage == 5
				aiB = _cfsLevelMenuSumm1.show(archInc as Float, blocInc as Float, harmInc as Float, onehInc as Float, smithInc as Float, twohInc as Float, 0.000000, 0.000000, 0.000000)
				if aiB == 0
					aiMessage = 8
				elseIf aiB == 1
					aiMessage = 0
				elseIf aiB == 2
					aiMessage = 6
				elseIf aiB == 3
					aiMessage = 7
				endIf
			elseIf aiMessage == 6
				aiB = _cfsLevelMenuSumm2.show(alteInc as Float, conjInc as Float, destInc as Float, enchInc as Float, illuInc as Float, restInc as Float, 0.000000, 0.000000, 0.000000)
				if aiB == 0
					aiMessage = 8
				elseIf aiB == 1
					aiMessage = 0
				elseIf aiB == 2
					aiMessage = 5
				elseIf aiB == 3
					aiMessage = 7
				endIf
			elseIf aiMessage == 7
				aiB = _cfsLevelMenuSumm3.show(alchInc as Float, larmInc as Float, lockinc as Float, pickInc as Float, sneaInc as Float, speeInc as Float, 0.000000, 0.000000, 0.000000)
				if aiB == 0
					aiMessage = 8
				elseIf aiB == 1
					aiMessage = 0
				elseIf aiB == 2
					aiMessage = 5
				elseIf aiB == 3
					aiMessage = 6
				endIf
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
				_cfsHeldXPFloatGV.SetValue(tempExp)
				cfshStatCost = statCost
				WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
				abMenu = false
			else
				aiMessage = 0
			endIf
		endIf
	endWhile
endFunction

; Skipped compiler generated GotoState
