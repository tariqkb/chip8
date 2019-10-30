class CPU {
    let memory: Memory
    let registers: Registers
    
    init(memory: Memory, registers: Registers) {
        self.memory = memory
        self.registers = registers
    }
    
    func run(instruction: Instruction) throws {
        switch(instruction) {
//        case .i00e0:
        case .i00ee:
            self.registers.pc = self.registers.stack[self.registers.sp]
            self.registers.sp -= 1
        case .i1nnn(let addr):
            // Only use last 12 bits
            self.registers.pc = 0x0FFF & addr
        case .i2nnn(let addr):
            registers.sp += 1
            registers.stack[registers.sp] = registers.pc
            registers.pc = 0x0FFF & addr
        case .i3xkk(let v, let byte):
            if registers.get(register: Int(v)) == byte {
                try registers.forwardPC()
            }
            
        default:
            fatalError("instruction not found \(instruction)")
        }
    }
}
