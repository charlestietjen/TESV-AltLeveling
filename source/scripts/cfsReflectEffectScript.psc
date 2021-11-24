Scriptname cfsReflectEffectScript extends ActiveMagicEffect

ObjectReference Property cfsLevelSpaceXMarker Auto
ObjectReference Property cfsReturnXMarker auto

location property cfsLevelSpaceLocation auto

actor property playerref auto


Event OnEffectStart(Actor t, Actor c)
  if c.GetCurrentLocation() == cfsLevelSpaceLocation
debug.notification("why isn't this working tho?")
    cfsReturnXMarker.moveto(playerref)
    playerref.moveto(cfsLevelSpaceXMarker)
  endif
EndEvent
