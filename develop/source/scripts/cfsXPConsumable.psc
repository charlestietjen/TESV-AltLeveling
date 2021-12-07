scriptname cfsXPConsumable extends activemagiceffect

float property xpV auto ;fill in editor properties to assign different values

cfsAlternateLevelVarsScript property VarsScript auto ;gotta invoke our increment function and tell it to track the gain

Event OnEffectStart(actor k, actor c)
  bool track = true
  VarsScript.IncXP(xpV, true)
EndEvent

;That's it. That's the script.
