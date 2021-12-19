# IMPORTANT NOTE TO SELF
Menu edits w/all sources included!! Study when time to spare!
https://github.com/mlthelama/ShowStats


# Riimindok - alternative leveling (working title) 
- to-do list

## Leveling NPC:

Refer to the lore/dialogue doc for details.

** denotes a finished feature

## RC Features:

- Experience points are tracked **
- Experience points are incremented on actor kill events where the player is the killer **
- A worldspace exists the player can instantly travel to under specific conditions **
- The worldspace contains an NPC that allows the player to spend experience points to level up individual skills **
- Skill experience gain is nullified unless the modded adv skill function is called **
- The cost of increasing a skill is proportional to player progression. **
- Experience points are incremented based on the difficulty of an encounter appropriately and consistently **
- A HUD element displays the current experience value the player has available **

## 1.0 Features:

- XP related consumables are injected into leveled item lists **
- The leveling worldspace contains conditionally enabled ornaments based on character milestones

## Addon Module - Bosses & Artifacts

- Unique combat encounters that are bosses or boss-like provide a specific experience value 
- Unique “boss” encounters grant a unique consumable
- The leveling worldspace contains a custom furniture item that allows the player to trade unique items for specific items

Post 1.0 Features:
	
- The leveling worldspace contains conditional custom furniture for producing items out of experience
- A forge that can exchange experience for weapons and armors
- An enchanter's table that can produce staffs, clothing and jewelry (maybe soul gems also)
- Additional lore implementation
	- I envision this as continuously growing library of statics that allow the player to read background lore on characters/items etc. related to the plugin.



## Boss Encounters Module

- New Dovahdiin dialogue, have her offer guidance to a boss location when you cross a level threshold or lifetime experience threshold. Bosses are still able to be found organically.
- Mostly scripted encounters, bosses with mechanics, specialized moves and abilities that need to be countered or brute forced to overcome.
- Bosses should scale with the enemy but always be challenging. Which will be absurdly difficult to balance.
- Have bosses adjust to +10 the player level. Condition magic effects to do different magnitudes of damage for differing player levels. Normal damage might be a challenge though 	- I think we can magic effect and still apply “weapon” damage, have it bypass spell resistance to stop it being resisted.
Bosses need logical resistances and weaknesses. I.e. a fiery boss should be extremely resistant if-not invulnerable to fire damage but much weaker to ice.
Ideally we utilize existing locations for these fights in areas the player will travel through naturally in the game. Colorful Magic is a good example of placement, bad example of encounter design.
Need to make use of attack data to govern the cooldown on various attacks.
Attack data can also help us to create openings by specifying long recovery times on challenging attacks.
Look through Vicn’s creature resource, see what else is out there for modder resources now, if anything new.
Bosses should be placed according to the likelihood a player of appropriate skills would encounter them. For example, bosses that would be more enjoyable to fight with melee should be encountered in areas likely to be visited during companions quests, mages should encounter fun bosses for mage gameplay in college areas, mzulft etc.)



## Bosses
Consort of Faydra
My potent fire atronach encounter from forever ago, remake a similar encounter because it was cool. (A mage centric location, maybe a secret area to the hitting the books quest, ties in well with The Caller) - Vicn wisp/flamequeen

- Towering Knight? Little on the nose.
-	 Tower Knight-esque encounter with a huge armored enemy. Give them an extremely large health pool, only a single elemental weakness to exploit or a weakness to 		bludgeon/piercing weapons. This should have an environmental gimmick you can exploit like a ballista you can trigger to deal a huge amount of damage or something. (Part 	of the snow elf ruins in dawnguard?) - vicn giant/ebonyking
-	 
- Aetherium Doll
	- Dwarven automaton that deploys projectile drones, fights almost exclusively at range, drone bit attack has a long cooldown, drones can be killed the by the player but 	gradually lose health after being deployed until death, their projectiles are high damage however. Under 40% health triggers a second phase of the fight and it deploys two larger drones, one pursues and attacks the player, the other targets the automaton with a beam that provides an extremely strong shield. (Can be placed in a new area 	in Blackreach) - vicn wisp/dwarvenempress & icewraith/dwarveneyebot
- Daedric boss encounter in a deadlands tower through a dormant portal that becomes active upon discovery - could do something w/a sigil stone at the end
- Do something related to the Brush of Truepaint from Oblivion, go into a painted world - double references. Could be something troll like to further reference the painted trolls from oblivion? Vicn probably has a weird huge troll or something similarly awful.



## Artifacts - Part of the Boss Encounters Module

- Dwemer Channelers
Gauntlets that when equipped grant the player a “projectile” spell that’s touch range with an extremely low charge time and high damage output, maybe force equip a true projectile in the left and touch on the right? Idk, should forcibly occupy both hands though. (these are like shitty iron man hands i guess)
- Kroh Fahdon (Sorcerer Ally) 
A greatsword that charges an additional magic damage enchantment while holding block, when fully charged can fire bloodskal style effects. Takes several seconds to charge up and uses a high percentage of magicka, projectiles are very powerful however.
- Staff of Heavy Firebombs
Casts arcing firebombs. They cause actors with a lower level than the user to ragdoll, direct hits cause any actors capable of ragdolling to do so.
- Automaton’s energy rod and barrier shield 
A staff that fires energy projectiles, no area damage but they deal non-elemental damage and reduce armor/spell resist for a period. The shield provides a spellbreaker effect that also increases armor rating while blocking.
- Thu'um Fiik (Voice Reflection/Mirror)
- A dragon themed greataxe that responds to the thu’um being used
Wuld increases player damage dramatically for a brief window
Feim makes the Axe ethereal for a duration, bypassing armor entirely
Yol, Ven, Fo, Strun all add an element to the axe for a duration
Raan projects an aura that buffs allied animals near you
Tiid “rewinds” your resources, tracking this would be script heavy so we just restore the 3 by a portion based on shout level instead.
Krii - Attacks reduce the targets maximum health for the remainder of combat.
Iiz - Shatters the ice prison for a bunch of frost damage? -Unsure how achievable this is, probably is, have a condition for the effect and also make the it dispel by the appropriate keyword. I forget if the dispel keywords go on the spell being dispelled or the dispeller, potential conflict i guess.




## Resource Links

total for nifskope mashups
https://youtu.be/q6YmHm1ksAg

https://www.nexusmods.com/skyrimspecialedition/mods/43402?tab=description
Vicn’s we have locally

Procedural dungeon generation, could be handy for short dungeon crawls to our boss areas

https://www.nexusmods.com/skyrimspecialedition/mods/37348?tab=description

Dwemer themed objects
https://www.nexusmods.com/skyrimspecialedition/mods/36054?tab=images&BH=1 

Snow elf themed objects
https://www.nexusmods.com/skyrimspecialedition/mods/57446 

Clutter - Some good lanterns and furniture in there
https://www.nexusmods.com/skyrimspecialedition/mods/22669 

Tutorials but has an alternate start one that may have helpful tips
https://www.nexusmods.com/skyrimspecialedition/mods/35186?tab=description 

Dictionary for xVAsynth
https://www.nexusmods.com/skyrimspecialedition/mods/56778 

Standalone followers guide - Could be useful for our npc visuals, maybe just google that tho
https://www.nexusmods.com/skyrimspecialedition/mods/49954 

Tools:
In-game coordinate/cell grabber
https://www.nexusmods.com/skyrimspecialedition/mods/30907 


Irrelevant:

Blender animation guide:
https://www.nexusmods.com/skyrimspecialedition/mods/50586 
