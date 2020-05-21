import nico
import globalinfo
importLevels #Imports all the levels so they're compiled with the project

var 
    currentLevel : Level

proc init()= 
    let pal = loadPaletteFromGPL("palette.gpl")
    setPalette(pal)
    loadSpriteSheet(0,"floor.png")

proc update(dt : Pfloat)= 
    currentLevel.update(dt)

proc onStateChange(state : GameState)=
    currentLevel = getActiveLevel()
    currentLevel.init()

proc draw()= 
    setColor(0)
    rectfill(getCamera().x,getCamera().y,screenSize.x,screenSize.y)
    currentLevel.draw()

onChangeState.add(onStateChange)
changeState(getState())
nico.init("BeefGame","Random Game")

nico.createWindow("nico",screenSize.x,screenSize.y,4,false)

loadFont(0,"font.png")
setFont(0)
fixedSize(true)
integerScale(true)

nico.run(init,update,draw)