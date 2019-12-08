public struct Interpreter {
    
    var v: [Register : UInt8]
    var i: UInt16
    var delay: UInt8
    var sound: UInt8
    var pc: UInt16
    var sp: Int
    var stack: [UInt16]
    var memory: [UInt8]
    
    init(memory: [UInt8], v0: UInt8, v1: UInt8, vf: UInt8, i: UInt16, delay: UInt8, sound: UInt8, pc: UInt16, sp: Int, stack: [UInt16]) {
        self.v = [.v0: v0, .v1: v1, .vf: vf]
        self.i = i
        self.delay = delay
        self.sound = sound
        self.pc = pc
        self.sp = sp
        self.stack = stack
        self.memory = memory
    }
    
    public init() {
        self.init(memory: [UInt8](repeating: 0, count: 4096), v0: 0, v1: 0, vf: 0, i: 0, delay: 0, sound: 0, pc: 0, sp: 0, stack: [UInt16](repeating: 0, count: 16))
    }
    
    public mutating func load(memory: [UInt8]) {
        self.memory = memory
    }
}

extension Interpreter {
    enum Chip8Error: Error {
        case pcOutOfBounds(pc: UInt16)
        case fatal(_ message: String)
    }
}
