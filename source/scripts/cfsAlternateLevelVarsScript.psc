Scriptname cfsAlternateLevelVarsScript extends Quest  

;properties
formlist property storedEnemies auto

globalvariable property _cfsHeldXPFloatGV auto
globalvariable property _cfsLifetimeXPAcq auto
globalvariable property _cfsLifetimeXPSpent auto
globalvariable property _cfsDeathCount auto 
globalvariable property _cfsLifetimeXPLost auto

cfsxpwidgetcore property WC auto

;private vars
string ltAc
string ltSp 
string ltDC
string ltLo 

;global mod Functions

function store(objectreference vic)
    storedEnemies.addform(vic)
    debug.notification("Storing objectref, count: " + storedEnemies.getsize())
endfunction

function resorrev(int res)
    if res == 1
        debug.notification("resurrecting actors")
        int i = storedEnemies.GetSize()
        while i > 0
            i -= 1
            actor e = storedEnemies.getat(i) as actor 
            e.resurrect()
        endwhile
        storedEnemies.revert()
    elseif res == 0 && storedEnemies.GetSize() > 0
        debug.notification("clearing res list")
        storedEnemies.revert()
    else
        debug.notification("none was passed to resorrev function")
    endif
endfunction

function IncXP(Float xpValue, bool notrack)
	Float heldxp = _cfsHeldXPFloatGV.GetValue()
    float ltXP = _cfsLifetimeXPAcq.GetValue()
	_cfsHeldXPFloatGV.SetValue(_cfsHeldXPFloatGV.GetValue() + xpValue)
	WC.UpdateWidget(_cfsHeldXPFloatGV.GetValue() as Int)
    if notrack
        _cfsLifetimeXPAcq.SetValue(ltXP + xpValue)
    endif
endFunction

;misc stats script

function register()
    RegisterforMenu("Journal Menu")
endfunction

function unregister()
    UnregisterForMenu("Journal Menu")
endfunction

event OnMenuOpen(string a)
    ;update globals
    UpdateCurrentInstanceGlobal(_cfsLifetimeXPSpent)
    UpdateCurrentInstanceGlobal(_cfsLifetimeXPLost)
    UpdateCurrentInstanceGlobal(_cfsLifetimeXPAcq)
    UpdateCurrentInstanceGlobal(_cfsDeathCount)
    ;store globals in strings
    ltSP = _cfsLifetimeXPSpent.GetValueInt() as string
    ltLo = _cfsLifetimeXPLost.GetValueInt() as string 
    ltAc = _cfsLifetimeXPAcq.GetValueInt() as string 
    ltDC = _cfsDeathCount.GetValueInt() as string 
    ;create arrays for stat data
    string[] ltSPOb = new string[4]
    ltSPOb[0] = "Lifetime Experience Spent"
    ltSPOb[1] = ltSP 
    ltSPOb[2] = "0"
    ltSPOb[3] = ""
    string[] ltLoOb = new string[4]
    ltLoOb[0] = "Lifetime Experience Lost"
    ltLoOb[1] = ltLo 
    ltLoOb[2] = "0"
    ltLoOb[3] = ""
    string[] ltAcOb = new string[4]
    ltAcOb[0] = "Lifetime Experience Acquired"
    ltAcOb[1] = ltAc 
    ltAcOb[2] = "0"
    ltAcOb[3] = ""
    string[] ltDcOb = new string[4]
    ltDcOb[0] = "Total Deaths"
    ltDcOb[1] = ltDC 
    ltDcOb[2] = "0"
    ltDcOb[3] = ""
    ;pass stat arrays to UI
    UI.InvokeStringA("Journal Menu", "_root.QuestJournalFader.Menu_mc.StatsFader.Page_mc.PopulateStatsList", ltAcOb)
    UI.InvokeStringA("Journal Menu", "_root.QuestJournalFader.Menu_mc.StatsFader.Page_mc.PopulateStatsList", ltSPOb)
    UI.InvokeStringA("Journal Menu", "_root.QuestJournalFader.Menu_mc.StatsFader.Page_mc.PopulateStatsList", ltDcOb)
    UI.InvokeStringA("Journal Menu", "_root.QuestJournalFader.Menu_mc.StatsFader.Page_mc.PopulateStatsList", ltLoOb)
endevent