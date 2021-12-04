Scriptname cfsUIExMenu extends ActiveMagicEffect

Import uiextensions
Import UIListMenu

actor property playerref auto

;Category Headers
String Property Category1 = "Combat" auto
String Property Category2 = "Magic" auto 
String Property Category3 = "Stealth" auto 
String Property Category4 = "Commit" auto 
String Property Category5 = "Cancel" auto

string[] rOptions ;main menu
string[] pOptions_1 ;combat menu
string[] pOptions_2 ;magic menu
string[] pOptions_3 ;stealth menu
string[] pOptions_4 ;confirm menu

formlist property skIncr auto 
formlist property skName auto

string[] skString
int[] _skillIncr
int property lastmenu auto hidden
float _tempCost
float _tempExp
int i 
int k

Event OnEffectStart(actor t, actor c)
    startMenu()
EndEvent

function startMenu()
    ;RegisterforMenu("Dialogue Menu")
    debug.notification("startMenu")
    lastmenu = 0
    skillIncrInit()
    ;testmenu()
    rootMenu()
endfunction

Event OnMenuClose(string a)
    lastmenu = 0
    skillIncrInit()
    rootMenu()
endevent

Function selectMenu()
    if lastmenu == 0 ;main menu
        rootMenu()
    elseif lastmenu == 1 ;confirm/cancel
    endif
EndFunction

function testmenu()
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    debug.notification("test menu function")
    listmenu.AddEntryItem(Category1, -1, -1, false)

    int mp = listmenu.OpenMenu()
    int mpButton = listmenu.GetResultInt()
endfunction

Function rootMenu()
    debug.notification("rootMenu")
    ;lastmenu = 0
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu 
    getBaseSkillValues()
    debug.notification("i = " + i + " k = " + k)
    rOps()
    bool sChanges

    ;pOptions = new string[5]
    ;pOptions[0] = Category1 ;Combat
    ;pOptions[1] = Category2 ;Magic
    ;pOptions[2] = Category3 ;Stealth
    ;pOptions[3] = Category4 ;Commit
    ;pOptions[4] = Category5 ;Cancel
    listmenu.AddEntryItem(rOption[0])

    i = 1
    k = 0
    While i < 19
        k = i - 1
        int nS = skString[k] as int + _skillIncr[i]
        string skillText = (rOptions[i] + ": Current: " + skString[k] + " New: " + nS as string)
        ;debug.notification("should be adding:" + skillText)
        ;debug.trace("should be adding:" + skillText)
        listmenu.AddEntryItem(skillText)
        i += 1
    endwhile

    listmenu.AddEntryItem(rOption[19])
    listmenu.AddEntryItem(rOption[20])

    int rm = listmenu.OpenMenu()
    int rmButton = listmenu.GetResultInt()

    if rmButton == 0 ;Header
        debug.notification("header selected")
        rootMenu()
    elseif rmButton < 20 ;while loop to increment appropriate skill selected
        debug.notification(rOptions[i] + " selected")
        i = rmButton - 1
        _skillIncr[i] = _skillIncr[i] + 1
        _tempExp -= _tempCost
        sChanges = true
        ;costCalc()
        rootMenu()
    elseif rmButton == 20 ;accept
        debug.notification("accept selected")
        if sChanges == true
            CategoryConfirm(sChanges)
        else
            ;closemenu
        endif
    else ;revert changes
        debug.notification("revert selected")
        i = 0
        while i < _skillIncr.length 
            _skillIncr[i] = 0
        endwhile
        ;rootMenu()
        lastmenu = 0
    endif
EndFunction

Function Category1()
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    getbaseskillvalues() ;grab all the players skills values in the skString array, reference function for index order
    cOps() ;populate array of options
    lastmenu = 1
    i = 0

    While i < pOptions_1.length ;add each option from array
        listmenu.AddEntryItem(pOptions_1[i] + " " + skString[i], -1, -1, false)
        i += 1
    endwhile

    int cm = listmenu.OpenMenu()
    int cmButton = listmenu.GetResultInt()

    if cmButton == 0 ;Archery
    elseif cmButton == 1 ;Block
    elseif cmButton == 2 ;HeavyArmor
    elseif cmButton == 3 ;TwoHanded
    elseif cmButton == 4 ;OneHanded
    elseif cmButton == 5 ;Smithing
    else
        lastmenu = 0
        rootMenu()
    endif

EndFunction

Function Category2()
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    getbaseskillvalues()
    mOps()
    lastmenu = 2
    i = 0
    k = 0
    while i < pOptions_2.length
        k = i + 6
        listmenu.AddEntryItem(pOptions_2[i] + " " + skString[k])
        i += 1
    endwhile

    int mm = listmenu.OpenMenu()
    int mmButton = listmenu.GetResultInt()

    if mmButton == 0 ;Alteration
    elseif mmButton == 1 ;Conjuration
    elseif mmButton == 2 ;Destruction
    elseif mmButton == 3 ;Enchant
    elseif mmButton == 4 ;Illusion
    elseif mmButton == 5 ;Restoration
    else ;back
        lastmenu = 0
        rootMenu()
    endif

EndFunction

Function Category3()
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu 
    getbaseskillvalues()
    sOps()
    lastmenu = 3
    i = 0
    k = 0

    while i < pOptions_3.length 
        k = i + 12
        listmenu.AddEntryItem(pOptions_3[i] + " " + skString[k], -1, -1, false)
        i += 1
    endwhile

    int sm = listmenu.OpenMenu()
    int smButton = listmenu.GetResultInt()

    if smButton == 0 ;alchemy
    elseif smButton == 1 ;light armor
    elseif smButton == 2 ;Lockpicking
    elseif smButton == 3 ;pickpocket
    elseif smButton == 4 ;sneak
    elseif smButton == 5 ;speech
    else ;back
        lastmenu = 0
        rootMenu()
    endif

EndFunction

Function CategoryConfirm(bool commit)
    UIListMenu listmenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu 
    confPop()
    lastmenu = 1
    i = 0

    while i < pOptions_4.length
        listmenu.AddEntryItem(pOptions_4[i], -1, -1, false)
        i += 1
    endwhile

    int cmenu = listmenu.OpenMenu()
    int cmenuButton = listmenu.GetResultInt()

    if cmenuButton == 0 ;commit
        ;incrementSkills()
        ;closemenu
        lastmenu = 0
    else ;back   
        lastmenu = 0
        rootMenu()
    endif
EndFunction 

;Populate skills array functions

Function cOps()
    pOptions_1 = new string[7]
    pOptions_1[0] = "Archery"
    pOptions_1[1] = "Block"
    pOptions_1[2] = "Heavy Armor"
    pOptions_1[3] = "Two Handed"
    pOptions_1[4] = "One Handed"
    pOptions_1[5] = "Smithing"
    pOptions_1[6] = "[Back]"
EndFunction

Function mOps()
    pOptions_2 = new string[7]
    pOptions_2[0] = "Alteration"
    pOptions_2[1] = "Conjuration"
    pOptions_2[2] = "Destruction"
    pOptions_2[3] = "Enchanting"
    pOptions_2[4] = "Illusion"
    pOptions_2[5] = "Restoration"
    pOptions_2[6] = "[Back]"
EndFunction

Function sOps()
    pOptions_3 = new string[7]
    pOptions_3[0] = "Alchemy"
    pOptions_3[1] = "Light Armor"
    pOptions_3[2] = "Lockpicking"
    pOptions_3[3] = "Pickpocket"
    pOptions_3[4] = "Sneaking"
    pOptions_3[5] = "Speech"
    pOptions_3[6] = "[Back]"
EndFunction

Function rOps()
    debug.notification("populating menu item array")
    rOptions = new string[20]
    rOptions[0] = "Held experience: " + _tempExp as string + "Cost: " + _tempCost as string
    rOptions[1] = "Archery"
    rOptions[2] = "Block"
    rOptions[3] = "Heavy Armor"
    rOptions[4] = "Two Handed"
    rOptions[5] = "One Handed"
    rOptions[6] = "Smithing"
    rOptions[7] = "Alteration"
    rOptions[8] = "Conjuration"
    rOptions[9] = "Destruction"
    rOptions[10] = "Enchanting"
    rOptions[11] = "Illusion"
    rOptions[12] = "Restoration"
    rOptions[13] = "Alchemy"
    rOptions[14] = "Light Armor"
    rOptions[15] = "Lockpicking"
    rOptions[16] = "Pickpocket"
    rOptions[17] = "Sneak"
    rOptions[18] = "Speech"
    rOptions[19] = "Commit"
    rOptions[20] = "Back"
EndFunction

Function getBaseSkillValues()
    debug.notification("filling base skill values")
    skString = new string[18]
    skString[0] = playerref.getbaseav("marksman") as string
    skString[1] = playerref.getbaseav("block") as string
    skString[2] = playerref.getbaseav("heavyarmor") as string
    skString[3] = playerref.getbaseav("twohanded") as string
    skString[4] = playerref.getbaseav("onehanded") as string 
    skString[5] = playerref.getbaseav("smithing") as string
    skString[6] = playerref.getbaseav("alteration") as string
    skString[7] = playerref.getbaseav("conjuration") as string
    skString[8] = playerref.getbaseav("destruction") as string 
    skString[9] = playerref.getbaseav("enchanting") as string 
    skString[10] = playerref.getbaseav("illusion") as string
    skString[11] = playerref.getbaseav("restoration") as string 
    skString[12] = playerref.getbaseav("alchemy") as string 
    skString[13] = playerref.getbaseav("lightarmor") as string 
    skString[14] = playerref.getbaseav("lockpicking") as string 
    skString[15] = playerref.getbaseav("pickpocket") as string 
    skString[16] = playerref.getbaseav("sneak") as string 
    skString[17] = playerref.getbaseav("speechcraft") as string
    ;i = 0 
    ;while i < skString.length 
    ;    skString[i] = playerref.getbaseav(skString[i]) as string
    ;endwhile
    ;i = 0
EndFunction

Function incrementSkills()
    i = 0
    while i < _skillIncr.length
        if _skillIncr[i] > 0
            k = i + 1
            game.incrementskillby(rOptions[k], _skillIncr[i])
        endif
    endwhile
EndFunction

Function confPop()
    pOptions_4 = new string[2]
    pOptions_4[0] = "Confirm"
    pOptions_4[1] = "Back"
endfunction

Function skillIncrInit()
    _skillIncr = new int[18]
    i = 0
    while i < 19
        _skillIncr[i] = 0
        i += 1
    endwhile 
EndFunction