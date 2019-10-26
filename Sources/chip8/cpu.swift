class CPU {
    let memory: Memory
    let registers: Registers
    
    init(memory: Memory, registers: Registers) {
        self.memory = memory
        self.registers = registers
    }
    
    func run(instruction: Instruction) {
        switch(instruction) {
//        case .i00e0:
        case .i00e0:
            if let topStack = self.registers.stack.last {
                self.registers.pc = topStack
            }
        case .i1nnn(let addr):
            // Only use last 12 bits
            self.registers.pc = 0x0FFF & addr
        case .i2nnn(let addr):
            
        default:
            fatalError("instruction not found \(instruction)")
        }
    }
}
