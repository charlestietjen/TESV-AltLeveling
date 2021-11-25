Scriptname cfsReflectEffectScript extends ActiveMagicEffect

ObjectReference Property cfsLevelSpaceXMarker Auto
ObjectReference Property cfsReturnXMarker auto

location property cfsLevelSpaceLocation auto

actor property playerref auto


Event OnEffectStart(Actor t, Actor c)
    cfsReturnXMarker.moveto(playerref)
    playerref.moveto(cfsLevelSpaceXMarker)
EndEvent
