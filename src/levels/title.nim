import nico
import level
import ../nicofancyfuncs
import ../levelmanager
import ../settings


let menuItems = ["Play","Options","Quit"]
var menuSelection = 0


proc init()=
    setCamera(0,0)

proc update(dt : Pfloat)=
    if(keyp(K_UP)): menuSelection = (menuSelection - 1 + menuItems.len).mod(menuItems.len)
    if(keyp(K_DOWN)): menuSelection = (menuSelection + 1 + menuItems.len).mod(menuItems.len)
    if(keyp(K_RETURN)):
        case menuSelection:
        of 0 : changeState(gsPlaying)
        of 2 : quit "Game closed"
        else : discard

proc draw()=
    let 
        titleFontScale = 3
        menuFontScale = 2
        title = "Nico thingy"
        titleX = screenSize.x.div(2) - (title.len * 2 * titleFontScale)
    sinPrint(title,titleX,3,5,2,titleFontScale,1)
    var index : int
    for item in menuItems:
        let 
            x = screenSize.x.div(2) - (item.len * 2 * menuFontScale)
            y = screenSize.y.div(2) + (index * 8 * menuFontScale)
            color = if(index == menuSelection): 3 else: 1
        sinPrint(item,x,y,7,1f,menuFontScale,color)
        inc index




var thisLevel = newLevel(init,
                         draw,
                         nil,
                         update)

proc getLevel(): Level = thisLevel

addLevel(gsMenu, getLevel)