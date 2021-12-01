Scriptname cfsResActorsScript extends Quest  

Formlist property storedEnemies auto 

cfsAlternateLevelVarsScript property VarsScript auto

event OnStoryKillActor(objectreference v, objectreference k, Location loc, Int cr, Int rel)
    ;actor vic = v as actor
    VarsScript.store(v)
    ;debug.notification("objectref sent to res list")
    self.stop()
Endevent