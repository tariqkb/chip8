class Registers {
    private(set) public var v0: UInt8
    var v1: UInt8
    var delay: UInt8
    var sound: UInt8
    /// Program counter
    var pc: UInt16
    /// Stack pointer - needs to be Int to use stack subscript
    var sp: Int
    var stack: [UInt16]
    
    var topstack: UInt16 {
        get {
            self.stack[self.sp]
        }
    }
    
    func forwardPC() throws {
        self.pc += 2
        // todo - remove hard coded value
        if pc > 4096 {
            throw Chip8Error.pcOutOfBounds(pc: pc)
        }
    }
    
    func set(register: Int, _ val: UInt8) {
        switch(register) {
        case 0:
            self.v0 = val
        case 1:
            self.v1 = val
        default:
            fatalError("register \(register) must be within bounds 0..8")
        }
    }
    
    func get(register: Int) -> UInt8 {
        switch(register) {
        case 0:
            return self.v0
        case 1:
            return self.v1
        default:
            fatalError("register \(register) must be within bounds 0..8")
        }
    }
    
    init(v0: UInt8, v1: UInt8, delay: UInt8, sound: UInt8, pc: UInt16, sp: Int, stack: [UInt16]) {
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
