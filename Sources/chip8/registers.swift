class Registers {
    var v0: UInt8
    var v1: UInt8
    var delay: UInt8
    var sound: UInt8
    /// Program counter
    var pc: UInt16
    /// Stack pointer
    var sp: UInt8
    let stack: [UInt16]
    
    init(v0: UInt8, v1: UInt8, delay: UInt8, sound: UInt8, pc: UInt16, sp: UInt8, stack: [UInt16]) {
        self.v0 = v0
        self.v1 = v1
        self.delay = delay
        self.sound = sound
        self.pc = pc
        self.sp = sp
        self.stack = stack
        
    }
    
    convenience init() {
        self.init(v0: 0, v1: 0, delay: 0, sound: 0, pc: 0, sp: 0, stack: [UInt16](repeating: 0, count: 16))
    }
}
