public class Interpreter {
    
    var memory: [UInt8]
    var v: [Register : UInt8]
    var i: UInt16
    var delay: UInt8
    public internal(set) var sound: UInt8
    var pc: UInt16
    var sp: Int
    var stack: [UInt16]
    
    let displayWidth: Int
    let displayHeight: Int
    public var display: [[UInt8]]
    
    var keyCurrentlyPressed: Key?
    public var keypresses: [Key:Bool] = [:]
    
    public convenience init() {
        self.init(memory: [UInt8](repeating: 0, count: 4096))
        self.loadSprites()
    }
    
    init(memory: [UInt8] = [UInt8](repeating: 0, count: 4096),
         v: [Register : UInt8] = [.v0: 0, .v1: 0, .v2: 0, .v3: 0, .v4: 0, .v5: 0,
                                  .v6: 0, .v7: 0, .v8: 0, .v9: 0, .va: 0, .vb: 0,
                                  .vc: 0, .vd: 0, .ve: 0, .vf: 0],
         i: UInt16 = 0,
         delay: UInt8 = 0,
         sound: UInt8 = 0,
         pc: UInt16 = 0,
         sp: Int = 0,
         stack: [UInt16] = [UInt16](repeating: 0, count: 16),
         displayWidth: Int = 64,
         displayHeight: Int = 32) {
        self.memory = memory
        self.v = v
        self.i = i
        self.delay = delay
        self.sound = sound
        self.pc = pc
        self.sp = sp
        self.stack = stack
        self.displayWidth = displayWidth
        self.displayHeight = displayHeight
        self.display = Array(repeating: Array(repeating: 0, count: displayWidth), count: displayHeight)
        
        self.loadSprites()
    }
    
    public func load(program: Program) {
        let memory = program.memory
        
        guard memory.count < 4096 - 0x200 else {
            fatalError("can't load that much memory count=\(memory.count)")
        }
        
        self.pc = 0x200
        self.memory = self.memory[0..<0x200] + memory + [UInt8](repeating: 0, count: 4096 - memory.count - 0x200)
    }
}

extension Interpreter {
    enum Chip8Error: Error {
        case pcOutOfBounds(pc: UInt16)
        case fatal(_ message: String)
    }
}
