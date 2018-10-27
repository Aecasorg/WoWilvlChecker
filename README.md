# WoWilvlChecker
A fast way for WoW raid leaders to check characters' ilvl and enchants/gems

## Why?
As a raid leader and guild leader I sometimes wanted to check up on guild members' ilvl on their characters that they want to join the raids with (main or alt runs). I could look up on WoW's homepage, however, that site is very slow with all the graphics that needs to load and constantly alt-tabbing whilst setting up for raid is just not ideal. I just wanted something that that's ideally fast to look up a character and give me just the essential information so I have an idea of what players I will have for a raid. 

## What I need
I would like an app that does the following:
* Easy to look up characters (the smartphone keyboard is ideal to look up weird character names with)
* Shows just the relevant information that I want (Name, Class, ilvl, Role/Spec, Gemmed?, Enchanted?)
* Easy and quick to read
* Possibly setting a filter that warns if there's something lacking, i.e. low ilvl, no gems or enchants.
* Stored characters so that their progress can be followed. 
* Fast lookup and refresh

## Challenges
* Extract and combine the data from 3 large json data fetches - items, talents & audit
* Pick out only relevant information from extracted data which has a large historical debt (14 years) where many parameters are not relevant any more to the current version of the game and are sometimes even inaccurate (e.g. enchants in audit).
* Make data fetch as fast a possible with an already slow API. 

## Prototype
Early prototype (Adobe XD).

<img src="https://i.imgur.com/1SsAbat.jpg">

Current version (as of Oct 2018 on an iPhone 8).

<img src="https://i.imgur.com/SDlsF4i.jpg?1">

### Changes needed (To Do):
* Introduce a help screen to explain swipes and long press.
* Animate and delay refresh swipe so it indicates if character data was refreshed.
* On refresh, indicate which data was updated?
* Implement pull-down to refresh all characters
* Speed up JSON data pull to extract all 3 sets of JSON data simultaneously rather than after each other, however, it should only work if all 3 sets of data pulls were successful. (Will this affect data extraction limit by x3?)
* Gem check to check all items that could possibly have it and show data as e.g. 2/4, like enchants. (Needs to check all items that can have gems and ignore those that can't as a summary is not provided by the API)
* Introduce filters? E.g. Order list by role, or ilvl, or alphabetically etc.
* Replace realm button with a settings button (cog wheel) and move realm button to inside search field. 
* Set up a warning sign on characters so that if something's lacking that shows up. Maybe red text/number when something's too low, such as the ilvl or gems. Alternatively highlight name as a way to draw attention to that character. 
* Alert when search can’t find character. 
* Move over to Blizzard's own new API service (hopefully faster lookups).
* [DONE] Search will need to be improved. I.e. to include realm choice.  
* [DONE] Update character/s button. Swipe right to update chosen character, left to delete?

### Pods used:
* Alamofire
* Realm
* SearchTextField
* SwipeCellKit (Removed)
 

## Credits
<div>Icons made by <a href="https://www.flaticon.com/authors/google" title="reload">reload</a> from <a href="https://www.flaticon.com/"     title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"     title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
