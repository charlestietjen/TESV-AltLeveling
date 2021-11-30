# file for plotting out code - don't copy over

#reference alias on the player, set them essential

#reference alias Script

#script moves a respawn xmarker to the players position every time their location changes (we could simply use the return xpmarker for this)

#on bleedout we wait for 2 seconds and then ragdoll the player, fade to black

#start a quest to regain lost xp
store the players held xp value in a quest variable and zero the held xp global
#enable a start disabled ash pile (placeholder) activator to the players position and enable it 
#move the player to the level space so they can catch a breather, especially since the xmarker may be in front of an immediate threat

#when the player activates the ash pile increment their held xp by the quest variable and zero the quest variable to prevent multiple activation
#disable the ash pile 
#complete the objective and quest 

#edge cases - there are a lot of locations in skyrim where respawning would make the location of death inaccessible
#look at other similar mods to gather info about problem areas
#most should be situations like, trigger boxes that lock doors behind players or areas with one way entry
#we should only need to account for the latter since we're respawning at a moving xmarker, if the player dies in sovngarde or w/e, they're still gonna go back there from the level hub

#edge case alias script
#make aliases in the alt level main quest for each trigger where the player gets locked in
#attach a general purpose script to those aliases that moves the xmarker onactivate/ontriggerboxentered/whatever other events need coverage
#hope that we can dynamically attach to these kinds of objectref without issues