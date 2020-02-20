import SGLMath

extension Interpreter {
    
    public var displayVectors: [vec2] {
        get {
//            return [vec2(0,0), vec2(5,5)]
            var vectors: [Vector2<Float>] = []
            for (y, row) in display.enumerated() {
                for (x, enabled) in row.enumerated() {
                    if enabled == 1 {
                        vectors.append(vec2(Float(x), Float(y)))
                    }
                }
            }
            return vectors
        }
    }
    
    func draw(x: Int, y: Int, bytes: [UInt8]) {
        // for each bit inside each byte, increment y mod HEIGHT and XOR onto x,y
        // increment x and mod WIDTH
        self[.vf] = 0
        for (byteIndex, byte) in bytes.enumerated() {
            let y = (y + byteIndex) % self.displayHeight
            for shift in 0...7 {
                let x = (x + shift) % self.displayWidth
                let bit = byte & (0b10000000 >> shift)
                if(bit != 0) {
                    if(display[y][x] == 1) {
                        self[.vf] = 1
                    }
                    display[y][x] ^= 1
                }
            }
        }
    }
    
    func clearScreen() {
        display = Array(repeating: Array(repeating: 0, count: displayWidth), count: displayHeight)
    }
    
    func loadSprites() {
        self.memory = unshiftFontSprites(into: self.memory)
    }
}

let fontSprites: [UInt8] = [
  0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
  0x20, 0x60, 0x20, 0x20, 0x70, // 1
  0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
  0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
  0x90, 0x90, 0xF0, 0x10, 0x10, // 4
  0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
  0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
  0xF0, 0x10, 0x20, 0x40, 0x40, // 7
  0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
  0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
  0xF0, 0x90, 0xF0, 0x90, 0x90, // A
  0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
  0xF0, 0x80, 0x80, 0x80, 0xF0, // C
  0xE0, 0x90, 0x90, 0x90, 0xE0, // D
  0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
  0xF0, 0x80, 0xF0, 0x80, 0x80  // F
]

func unshiftFontSprites(into memory: [UInt8]) -> [UInt8] {
    guard memory.count > 80 else {
        fatalError("not enough room to unshift sprites, needs 80")
    }
    return fontSprites + memory[80..<memory.count]
}
