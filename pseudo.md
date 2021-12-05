## another pseudo file because reasons

papyrus script fills an array with all the player's current base skill values.

## Papyrus

levelmenucustom   extends quest

import UI
import UICallback

formlist property skStrings auto ;assign skill names to formlist in editor

string levelMenu = "./cfslevelmenu.swf"

function openLevelMenu()

RegisterForMenu("CustomMenu")

int skValue = new int[18] skValue

while i < skValue.length
  skValue[i] = skStrings.GetAt(i)
  i += 1
endwhile

InvokeIntA(levelMenu, "_root.skValue[]", skValue[])

Invoke(levelMenu, "_root.Open()")

OpenCustomMenu(levelMenu)

EndFunction

Event OnMenuClose("CustomMenu")
  ;we need to reference the increment skill array from AS2 but i'm drawing blanks right now for that, check the UI/UICallback sources, might shed light
  skIncrement[] ;our array
  int i = 0
  while i < skIncrement.length
    if skIncrement[i] > 0 ;incrementskillby will inc the skill by 1 if passed 0 so we need to check
      playerref.incrementskillby("marksman", skIncrement)
    endif
    i += 1
  endwhile
EndEvent

## AS2

var skValue = new Array();
skValue[0] = 0;
etc. through [18]

// populate an array 
function Open() {
  archOb.count = skValue[0] //could probably be smart and make an array of the objects and use a for loop, do whatever you're confident with at the time
  //add some event listeners - refer to skyui source for usage examples, searching online unclear, we need listeners for hover, click, UI move controls and the activate & back controls.
  
}

Use states to change the behavior of ui controls on an activate event while on a skill object, allow state to revert to ui movement with activate or back controls
assign an int for each selectable menu item

Mouse control is ez, on hover we make the adjustment arrows for the hovered skill visible. Clicking on the buttons increases the skill if affordable, plays an error noise if it's not affordable and the left arrows allow reducing the skill as low as the starting point on menu open.

While in the navigation state move events increase or decrease the int. When the menu opens the int is assigned a value of 18, starting the menu at accept.

menu layout for int assignment follows:

0   1   2

3   4   5

6   7   8

9   10  11

12  13  14

15  16  17

  18  19

A moveleft event will -1 the int, right will +1 the int, selecting the option immediately left or right. move up and move down will +3 or -3. Edge case if statements need to be used to catch moving up from the top row, left from zero, down from the bottom row and left/right/down from the edges of confirm/revert.

navigate state needs to call a function on every move event to set the current arrow objects not visible, change the int and set the new arrows visible.

The activate control listener shares code with click event on confirm/revert. The activate listener for skill objects changes the controller code to an edit state.

Edit state

In edit state move right event checks held exp against the skill cost, if the skill is too expensive an error sound plays and nothing happens. if the skill is affordable then the value is incremented by one, held exp is reduced by skill cost and skill cost is recalculated by calling a function to do so. move left events lower the skill if it has been raised as low as the base value passed initially.
 
activate events or back events will return to navigate state. Maybe back events should cancel the skill change? IDK sounds like more work.

each time a skill is raised we add 1 to the appropriate index of an incrementSkill array.

On accept clicked/activated we display a second layer asking for confirm/cancel. Use the same navigation concept as above, assign 0, 1 and -/+ 1 to move between options.

Revert doesn't prompt confirm/cancel, repopulates each count class to their original value on open and clears the increment array.

When confirming we send an array of 18 ints back to papyrus, for each skill. And call skse.closemenu("CustomMenu)
