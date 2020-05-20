import nico,macros,os
import /levels/level

macro importLevels*(): untyped=
    var bracket  = newNimNode(nnkBracket)
    for x in walkDir("./src/levels/",true):
        if(x.kind == pcFile):
            let split = x.path.splitFile()
            if(split.ext == ".nim"):
                bracket.add(ident(split.name))

    var node = newStmtList(
                newNimNode(nnkImportStmt).add(
                    newNimNode(nnkInfix).add(
                        ident("/"),
                        newNimNode(nnkPrefix).add(
                            ident("/"),
                            ident("levels")
                        ),
                        bracket
                    )
                )
            )
    return node

type
    GameState* = enum
        gsMenu,gsPlaying

var compStateLevel {.compileTime.} : array[GameState, proc() : Level{.nimcall.}]

template addLevel*(state : static GameState, level : proc() : Level{.nimcall.})=
    static:
        echo "Added Level"
        compStateLevel[state] = level


const stateLevel = compStateLevel
var
    screenSize* : (int,int) = (384,288)
    onChangeState* : seq[proc(newState : GameState)]
    currentState = gsMenu

proc x*(i : (int,int) | (Pint,Pint)) : int = i[0]
proc y*(i : (int,int) | (Pint,Pint)) : int = i[1]

proc changeState*(state : GameState)=
    currentState = state
    for x in onChangeState:
        x(state)

proc getLevel*():Level= stateLevel[currentState]()

proc getState*():GameState = currentState