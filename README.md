# nico-helper
A small base project for easily expandible Nico games. It uses a scene like approach for programming to avoid a long oversized main file.
Simply clone this repo as a base and run `nimble install`. Then just add to the `gamestate` file for each level. Finally create a new level inside of the `/levels/` and with the same format as the included levels. Adding the macro to add levels.

```nim
#In gamestate
type
    GameState = enum
        gsTitle, gsCredits, gsGames, gsHighScore, gsYourLevelNameHere #Each of these will be used like a scene UID
```

```nim
#in your new level file
import nico, level, levelmanager
proc init()= discard #Real code should be here
proc update(dt : Pfloat)= discard #Real code should be here
proc draw()= discard #Real code should be here

var thisLevel = Level(init: init, update: update, draw: draw )
proc getLevel(): Level = thisLevel

addLevel(gsYourLevelNameHere, getLevel)#This adds the level to the LUT/FSM
```
