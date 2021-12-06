Scriptname cfsReflectEffectScript extends ActiveMagicEffect

ObjectReference Property cfsLevelSpaceXMarker Auto
ObjectReference Property cfsReturnXMarker auto

location property cfsLevelSpaceLocation auto

formlist property _cfsSafeLocRefTypes auto

actor property playerref auto

message property _cfsNoTP auto


Event OnEffectStart(Actor t, Actor c)
    int i = _cfsSafeLocRefTypes.GetSize()
    location tloc = t.getcurrentlocation()
    bool safe = false
    while i
        i -= 1
        keyword lkw = _cfsSafeLocRefTypes.GetAt(i) as Keyword
        if tloc.haskeyword(lkw)
            tp()
        Else
            _cfsNoTP.show()
        endif 
    endwhile
EndEvent

function tp()
    cfsReturnXMarker.moveto(playerref)
    utility.wait(1) ;wait added to ensure return marker places before the player is moved
    playerref.moveto(cfsLevelSpaceXMarker)
endfunction
