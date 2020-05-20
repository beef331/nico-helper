import nico
type
    Level* = object
        init* : proc()
        update* : proc(dt : Pfloat)
        draw* : proc()