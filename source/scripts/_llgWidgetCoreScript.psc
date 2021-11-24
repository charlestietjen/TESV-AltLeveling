Scriptname _llgWidgetCoreScript extends SKI_WidgetBase

;properties
Actor property playerRef Auto

Bool xpVisible = false ;whether the widget should be visible
Int xpCount = 0 ;the current value the widget should display
Int counterSize = 0 ;the size of the widget

;Functions for setting and getting whether the widget is visible
Bool Property Visible
  Bool Function Get()
    Return xpVisible
  EndFunction

  Function Set(bool xp_val)
    xpVisible = xp_val
    If (Ready)
      UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", xpVisible)
    endif
  EndFunction
endProperty

;Functions for setting and getting the count value of the widget
Int Property Count
  Int Function Get()
    Return xpCount
  EndFunction

  Function Set(int xp_val)
    xpCount = xp_val
    If(Ready)
      UI.InvokeInt(HUD_MENU, WidgetRoot, ".setCount", xpCount)
    EndIf
  EndFunction
endProperty

;Functions for setting and getting the size of the widget
Int Property Size
  Int Function Get()
    Return counterSize
  EndFunction

  Function Set(int xp_val)
    counterSize = xp_val
    if (Ready)
      UpdateScale()
    EndIf
  EndFunction
endProperty

;Functions for Setting the X and Y positions of the widget
Function SetX(float xfX)
  If (Ready)
    X = xfX
  EndIf
EndFunction

Function SetY(float xfY)
  if (Ready)
    Y = xfY
  EndIf
EndFunction

;Functions for setting the anchor positions
Function SetHorizontalAnchor(String asAnchor)
  If (Ready)
    HAnchor = asAnchor
  EndIf
EndFunction

Function SetVerticalAnchor(string asAnchor)
  If (Ready)
    VAnchor = asAnchor
  EndIf
EndFunction

;Function for setting the transparency
Function SetTransparency(Float afAlpha)
  If (Ready)
    Alpha = afAlpha
  EndIf
EndFunction

;When the widget resets it should update it's scale, call onwidgetreset on the parent script and then set the HUD visible and count properties
Event OnWidgetReset()
  UpdateScale()
  Parent.OnWidgetReset()
  UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", xpVisible)
  UI.InvokeInt(HUD_MENU, WidgetRoot + ".setCount", xpCount)
EndEvent

;The path of the widgets swf
String Function GetWidgetSource()
  Return "altleveling/xpcountui.swf"
EndFunction

;the script that owns the widget (this script)
String Function GetWidgetType()
  Return "_llgWidgetCoreScript"
EndFunction

;Function to update the widget
Function UpdateStatus()
EndFunction

;Function to update the scale of the widget
Function UpdateScale()
  UI.SetInt(HUD_MENU, WidgetRoot, + ".Scale", counterSize)
EndFunction
