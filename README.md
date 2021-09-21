# ttt2-role-alch
This is a custom role for TTT2 called the Alchemist.
They are an Innocent role that 'brews' potions over time that give benefits when thrown.


CURRENT PROGRESS:
Alchemist appears ingame, albeit without a proper icon.
They do have a timer set up to give them a potion, but until I can get the first potion working correctly, the randomization function isn't present.
Once the potions are all working, introduce a table and make use of a randomness algorithm, likely math.random
After that, assign the timer to a HUD element to show when the next potion will be ready.

The first potion in the works is the healing potion. Currently, it's not working. 
It doesn't appear in the player's FOV correctly despite appearing just fine when thrown.
It doesn't heal players on impact and only throws out errors.
The only thing that works is that it 'detonates' on impact with a physical object, such as a player or wall.


NEXT STEP:
Get the healing potion to function correctly.


FUTURE PLANS:
Once Alchemist is soundly working, add a Traitor role variant called the Witch.
Have them appear as an Alchemist to everyone but fellow Traitors, adding a Defective-esque layer of distrust.

Adopt a system akin to Imposter's ability to cycle through sabotage stations, but for potion selection. 
After getting a cycle-able potion menu working, turn random potion selection into a toggle. This way, servers can choose which method they'd prefer.
