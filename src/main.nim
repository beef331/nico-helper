import nico
import levelmanager, settings
importLevels #Imports all the levels so they're compiled with the project

var 
    currentLevel : Level

proc init()= 
    let pal = loadPaletteFromGPL("palette.gpl")
    setPalette(pal)
    loadSpriteSheet(0,"floor.png")

proc update(dt : Pfloat)= 
    if(currentLevel.update.isSome): currentLevel.update.get()(dt)

proc onStateChange(state : GameState)=
    if(currentLevel.exit.isSome): currentLevel.exit.get()()
    currentLevel = getActiveLevel()
    if(currentLevel.init.isSome): currentLevel.init.get()()

proc draw()= 
    setColor(0)
    rectfill(getCamera().x,getCamera().y,screenSize.x,screenSize.y)
    if(currentLevel.draw.isSome): currentLevel.draw.get()()

onChangeState.add(onStateChange)
changeState(getState())
nico.init("BeefGame","Random Game")

nico.createWindow("nico",screenSize.x,screenSize.y,4,false)

loadFont(0,"font.png")
setFont(0)
fixedSize(true)
integerScale(true)

nico.run(init,update,draw)