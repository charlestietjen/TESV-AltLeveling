Scriptname cfsResActorsScript extends Quest  

; kill actor script that adds a valid kill to the formlist, quest node is conditioned for validation

Formlist property storedEnemies auto 

cfsAlternateLevelVarsScript property VarsScript auto

event OnStoryKillActor(objectreference v, objectreference k, Location loc, Int cr, Int rel)
    actor vic = v as actor
    storedEnemies.addform(vic)
    debug.notification("Storing: " + vic.GetName() + ", # Stored: " + storedEnemies.getsize())
    ;VarsScript.store(vic)
    ;debug.notification("objectref sent to res list")
    self.stop()
Endevent