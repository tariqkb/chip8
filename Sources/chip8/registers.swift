class Registers {
    let v0: UInt8
    let v1: UInt8
    let delay: UInt8
    let sound: UInt8
    let programCounter: UInt16
    let stackPointer: UInt8
    let stack: [UInt16]
    
    init() {
        self.v0 = 0
        self.v1 = 0
        self.delay = 0
        self.sound = 0
        self.programCounter = 0
        self.stackPointer = 0
        self.stack = [UInt16](repeating: 0, count: 16)
    }
}
