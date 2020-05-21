import nico


proc sinPrint*(words : string, x,y:Pint , wobbleSpeed = 8f, wobbleScale = 1.5f, fontScale, color : Pint = 1)=
    setColor(color)
    for i in 0..<words.len:
        printc($words[i], x + i * (4 * fontScale), y + sin(time() * wobbleSpeed + i.float) * wobbleScale, fontScale)
