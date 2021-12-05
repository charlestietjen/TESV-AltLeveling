## another pseudo file because reasons

papyrus script fills an array with all the player's current base skill values.

## Papyrus

levelmenucustom   extends quest

import UI
import UICallback

formlist property skStrings auto ;assign skill names to formlist in editor

string levelMenu = "./cfslevelmenu.swf"

function openLevelMenu()

int skValue = new int[18] skValue

while i < skValue.length
  skValue[i] = skStrings.GetAt(i)
  i += 1
endwhile

InvokeIntA(levelMenu, "_root.skValue[]", skValue[])

Invoke(levelMenu, "_root.Open()")

OpenCustomMenu(levelMenu)

EndFunction

## AS2

var skValue = new Array();
skValue[0] = 0;
etc. through [18]

// populate an array 
function Open() {
  archOb.count = skValue[0] //could probably be smart and make an array of the objects and use a for loop, do whatever you're confident with at the time
  //add some event listeners - refer to skyui source for usage examples, searching online unclear
  
}
