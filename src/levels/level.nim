import nico, options
export options
type
    Level* = object
        init* : Option[proc()]
        update* : Option[proc(dt : Pfloat)]
        draw* : Option[proc()]
        exit* : Option[proc()]