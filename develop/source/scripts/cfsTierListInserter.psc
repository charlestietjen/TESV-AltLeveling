cfsTierListInserter Extends ReferenceAlias


formlist property slist auto
formlist property alist auto
formlist property blist auto
formlist property clist auto
formlist property dlist auto
formlist property elist auto

faction property sfac auto
faction property afac auto
faction property bfac auto
faction property cfac auto
faction property dfac auto
faction property efac auto


faction[] f = new faction[6]
f[0] = sfac
f[1] = afac
f[2] = bfac
f[3] = cfac
f[4] = dfac
f[5] = efac

formlist[] t = new formlist[6]
t[0] = slist
t[1] = alist
t[2] = blist
t[3] = clist
t[4] = dlist
t[5] = elist

Event OnInit() ;oninit doesn't handle any code since it holds up other papyrus functions
  Debug.notification("Inserting factions into tier lists")
  RegisterForSingleUpdate(1)
EndEvent

;patching is done by running through the two arrays with properties filled out by the editor, we can reuse this simple script for any compatibility patch to handle any
;enemy that doesn't require the addition of unique items
Event OnUpdate()
  int i = 0
  while i < 6
    t[i].addform(f[i])
    i += 1
  endwhile
  Debug.Notification("Done patching tier lists")
EndEvent
