import nico

var
    screenSize* : (int,int) = (384,288)

proc x*(i : (int,int) | (Pint,Pint)) : int = i[0]
proc y*(i : (int,int) | (Pint,Pint)) : int = i[1]
