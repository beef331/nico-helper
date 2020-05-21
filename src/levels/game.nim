import nico
import level
import ../globalinfo

var x,y = 0f
let speed = 50f
proc init()=
    x = 0
    y = 0

proc update(dt : Pfloat)= 
    if(key(K_LEFT)): x -= dt * speed
    if(key(K_RIGHT)): x += dt * speed
    if(key(K_UP)): y -= dt * speed
    if(key(K_DOWN)): y += dt * speed
    if(key(K_ESCAPE)): changeState(gsMenu)


proc draw()=
    setCamera(x,y)
    setSpritesheet(0)
    for x in 0..screenWidth.div(32):
        for y in 0..screenHeight.div(32):
            spr(0,x * 32,y * 32, 32, 32)

var thisLevel = Level(init : init, update : update, draw : draw)

proc getLevel():Level = thisLevel

addLevel(gsPlaying, getLevel)