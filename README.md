# WoWilvlChecker
A fast way for WoW raid leaders to check characters' ilvl and enchants/gems

## Why?
As a raid leader and guild leader I sometimes wanted to check up on guild members' ilvl on their characters that they want to join the raids with (main or alt runs). I could look up on WoW's homepage, however that site is seriously slow with all the graphics that need to load. I just wanted something that that's ideally fast too look up a character and give me just the essential information so I have an idea of what players I will have for raid. 

## What I need
I would like an app that does the following:
* Easy to look up characters (the smartphone keyboard is ideal to look up weird character names with)
* Shows just the relevant information that I want (Name, Class, ilvl, Role/Spec, Gemmed?, Enchanted?)
* Easy to read
* Possibly setting a filter that warns if there's something lacking, i.e. low ilvl, no gems or enchants.
* Stored characters so that their progress can be followed. 
* Fast lookup and refresh

## Challenges
* Extract and combine the data from 3 large json data fetches - items, talents & audit
* Pick out only relevant information from extracted data which have a large historical debt (10 years) where many parameters are not relevant any more to the current version of the game. 
