Scriptname cfsReturnPortalScript extends ObjectReference

ObjectReference Property cfsReturnXMarker auto

Actor Property playerref auto


Event OnActivate(ObjectReference a)
  a.moveto(cfsReturnXMarker)
endevent
