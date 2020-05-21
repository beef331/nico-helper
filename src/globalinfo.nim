import nico,macros,os
import /levels/level
import gamestate

export gamestate

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

var compStateLevel {.compileTime.} : array[GameState, proc() : Level{.nimcall.}]

template addLevel*(state : static GameState, level : proc() : Level{.nimcall.})=
    static:
        doAssert compStateLevel[state] == nil, "Readded a level state"
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

proc getActiveLevel*():Level= stateLevel[currentState]()

proc getState*():GameState = currentState