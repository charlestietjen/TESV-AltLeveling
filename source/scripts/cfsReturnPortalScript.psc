Scriptname cfsReturnPortalScript extends ObjectReference

ObjectReference Property cfsReturnXMarker auto

Actor Property playerref auto


Event OnTriggerEnter(ObjectReference a)
  debug.notification("entered return trigger")
  a.moveto(cfsReturnXMarker)
endevent
