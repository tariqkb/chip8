class Interpreter {
    var registers: [Register : UInt8]
    var delay: UInt8
    var sound: UInt8
    
    /// Program counter
    var pc: UInt16
    
    /// Stack pointer - needs to be Int to use stack subscript
    var sp: Int
    var stack: [UInt16]
    
    let memory: Memory
    
    init(memory: Memory, v0: UInt8, v1: UInt8, delay: UInt8, sound: UInt8, pc: UInt16, sp: Int, stack: [UInt16]) {
        self.registers = [.v0: v0, .v1: v1]
        self.delay = delay
        self.sound = sound
        self.pc = pc
        self.sp = sp
        self.stack = stack
        
        self.memory = memory
    }
    
    convenience init() {
        self.init(memory: Memory(bytes: 4096), v0: 0, v1: 0, delay: 0, sound: 0, pc: 0, sp: 0, stack: [UInt16](repeating: 0, count: 16))
    }
}
