
extension Interpreter {
    func run(instruction: Instruction) throws {
        
        switch(instruction) {
//        case .i00e0:
        case .ret:
            self.pc = self.stack[self.sp]
            self.sp -= 1
        case .jump(let addr):
            // Only use last 12 bits
            self.pc = 0x0FFF & addr
        case .call(let addr):
            sp += 1
            stack[sp] = pc
            pc = 0x0FFF & addr
        case .seByte(let vx, let byte):
            if self[vx] == byte {
                try forwardPC()
            }
        case .sneByte(let vx, let byte):
            if self[vx] != byte {
                try forwardPC()
            }
        case .se(let vx, let vy):
            if self[vx] == self[vy] {
                try forwardPC()
            }
        
        
        default:
            throw Chip8Error.fatal("instruction not found \(instruction)")
        }
    }
}
