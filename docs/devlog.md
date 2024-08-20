i didn't even know i was going to do this jam, but i came up with the idea once i heard the theme! what a fun way to live: spontaneously!

# 16/08/2024 (96h left)
- made game idea
- made godot project
- made gdd mostly, with MVP
- made repo
- going to use godot 4.3 and hopefully single-threaded web exporting means i don't have to use a NodeJS server to run it locally? if so, that's fine, i'll still be testing it on itch.io lol
- i have good ideas for the itch.io page theming too! hopefully this pans out smoothly...
- made globe blockout
- made test level

# 17/08/2024 (72h left)
- spent 2 hours trying to use other people's 3d player controller scripts, yeah wow i'm just going to make my own i guess
- just going to focus on simple movement, using this 3rd person camera addon i found too
- damn that took too long, i had self.position + direction as the target, when i just needed the direction for my calculation...
- package time ! !
- added package, package_spawn_location
- accidentally overwrote my timer.gd with country_text.gd, got it back thanks to github! yay committing :D!
- made a big list of countries i'll include

# 18/08/2024 (48h left uh oh that's scary)
- in a car now, going to try make the location spawn instantiation work, now THIS is mobile gamedev
- realising the drop-off hitboxes are going to either be a small sphere, which works fine for a small country like ireland / cyprus, but russia (even at this scale) is going to need a much bigger circle... do i have to make the big collision by hand? or i can have all the colliders there, but disabled, and then enable them when it's the active drop-off country
- i also have to make my own models, eoin said NOO!!! (i hate 3d modelling and 3d animation)
- just found a godot 4.3 bug, nvm it might be my keyboard, the duplicate scene enter name section wouldn't let me use backspace, or select any text with shift+arrow
  - ^ but then it wouldn't let me do anything in the godot text editor too... maybe it was a lagging thing, except it just ate my input and didn't fill my text afterwards
- got a bit of the destination logic in there, it's just another package touching mechanic, kills itself on touch && can_touch
- been watching some jvscholz recently, very motivating stuff! been doing 4 hour work sessions, and it seems to be working
- main gameloop done :DD
- need to make the assets now maybe?
- just finished placing little red dots for all 40 countries, hmm you can just keep walking around central europe most of the time... so you only really need to learn east-asia and the americas
- just did it all again by typing the names out, yeesh
- okay made the map, put it in, added all the locations BY HAND to the array, now it works :DDDD
- need to position all locations, make round system, then MVP is done

# 19/08/2024 (24h left)
- whoops forgot to keep updating this lol
- did the location, MVP IS DONE!!!
- uploaded publicly to itch.io
- made package model
- made rounds system, game tells you your final time after 15 deliveries
- made feedback.md for the player feedback
- 2 players so far
- made all the hints and arrows and menus work, all works with controllers too! button focusing and manipulating the order of ui / buttons is fun!
- making globe's model and... i forgot how fun lowpoly modelling is... why was i putting this off so much D:
- gonna give 'em a little delivery hat

# 20/08/2024 (>24h left)
- finished the globe model last night, did animations this morning, they are bad but they are there
- the models are done, i just made all of my audio sfx in 15 minutes (some acapella...) AND i made a banger Windwaker-inspired piece in 30 MINUTES!!! so fast, sick name too: "Kaiju Delivery Service"
- just gotta implement the sound, then it's the final build
