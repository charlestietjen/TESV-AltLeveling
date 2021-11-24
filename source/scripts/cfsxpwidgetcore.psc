scriptName cfsXPWidgetCore extends SKI_WidgetBase

;-- Properties --------------------------------------
globalvariable property _cfsHeldXPFloatGV auto
Bool property Visible
	Bool function get()

		return xpVisible
	endFunction
	function set(Bool a_val)

		xpVisible = a_val
		if self.Ready
			ui.InvokeBool(self.HUD_MENU, self.WidgetRoot + ".setVisible", xpVisible)
		endIf
	endFunction
endproperty
Int property uiSize auto
Int property Count
	Int function get()

		return xpCount
	endFunction
	function set(Int a_val)

		xpCount = a_val
		if self.Ready
			ui.InvokeFloat(self.HUD_MENU, self.WidgetRoot + ".setCount", xpCount as Float)
		endIf
	endFunction
endproperty
Int property xpCount auto
actor property playerref auto
Int property Size
	Int function get()

		return uiSize
	endFunction
	function set(Int a_val)

		uiSize = a_val
		if self.Ready
			self.UpdateScale()
		endIf
	endFunction
endproperty
cfsspendxpmenuscript property xpScript auto
sound property cfsxpacquire auto
Float property lkXP auto
Float property xpacquirevolume auto
Bool property xpVisible auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function SetTransparency(Float afAlpha)

	if self.Ready
		self.Alpha = afAlpha
	endIf
endFunction

; Skipped compiler generated GetState

function UpdateScale()

	ui.SetInt(self.HUD_MENU, self.WidgetRoot + ".Scale", uiSize)
endFunction

String function GetWidgetSource()

	return "altleveling/xpcountui.swf"
endFunction

function UpdateStatus()

	if self.Ready && lkXP == _cfsHeldXPFloatGV.GetValue()
		ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", _cfsHeldXPFloatGV.GetValue() as Int)
	elseIf self.Ready && lkXP < _cfsHeldXPFloatGV.GetValue()
		while lkXP < _cfsHeldXPFloatGV.GetValue()
			lkXP += 1 as Float
			ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", lkXP as Int)
		endWhile
	elseIf self.Ready && lkXP > _cfsHeldXPFloatGV.GetValue()
		while lkXP > _cfsHeldXPFloatGV.GetValue()
			lkXP -= 1 as Float
			ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", lkXP as Int)
		endWhile
	endIf
endFunction

function SetY(Float afY)

	if self.Ready
		self.Y = afY
	endIf
endFunction

; Skipped compiler generated GotoState

String function GetWidgetType()

	return "cfsXPWidgetCore"
endFunction

function SetVerticalAnchor(String asAnchor)

	if self.Ready
		self.VAnchor = asAnchor
	endIf
endFunction

function OnWidgetReset()

	RequireExtend = false
	self.UpdateScale()
	parent.OnWidgetReset()
	ui.setbool(self.HUD_MENU, self.WidgetRoot + "._visible", true)
	ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", _cfsHeldXPFloatGV.GetValue() as Int)
endFunction

function SetHorizontalAnchor(String asAnchor)

	if self.Ready
		self.HAnchor = asAnchor
	endIf
endFunction

function updateWidget(Int wValue)

	if self.Ready && lkXP == _cfsHeldXPFloatGV.GetValue()
		ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", _cfsHeldXPFloatGV.GetValue() as Int)
	elseIf self.Ready && lkXP < _cfsHeldXPFloatGV.GetValue()
		Int acquiresfx = cfsxpacquire.play(playerref as objectreference)
		sound.SetInstanceVolume(acquiresfx, xpacquirevolume)
		while lkXP < _cfsHeldXPFloatGV.GetValue()
			ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", lkXP as Int)
			lkXP += 1 as Float
		endWhile
		ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", _cfsHeldXPFloatGV.GetValue() as Int)
	elseIf self.Ready && lkXP > _cfsHeldXPFloatGV.GetValue()
		while lkXP > _cfsHeldXPFloatGV.GetValue()
			lkXP -= 1 as Float
			ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", lkXP as Int)
		endWhile
		ui.InvokeInt(self.HUD_MENU, self.WidgetRoot + ".setCount", _cfsHeldXPFloatGV.GetValue() as Int)
		lkXP = _cfsHeldXPFloatGV.GetValue()
	endIf
endFunction

function SetX(Float afX)

	if self.Ready
		self.X = afX
	endIf
endFunction
