import nico, options
export options
type
    Level* = object
        init* : Option[proc()]
        update* : Option[proc(dt : Pfloat)]
        draw* : Option[proc()]
        exit* : Option[proc()]

proc newLevel*(init, draw, exit: proc() = nil, update : proc(dt: Pfloat) = nil): Level =
    Level(init: option[proc()](init),
         draw: option[proc()](draw),
         exit: option[proc()](exit),
         update: option[proc(dt : Pfloat)](update))