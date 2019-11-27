extension Interpreter {
    mutating func run(instruction: Instruction) throws {
        
        switch(instruction) {
//        case .i00e0:
        case .ret:
            self.pc = self.stack[self.sp]
            self.sp -= 1
            
        case .jump(let addr):
            // Only use last 12 bits
            self.pc = addr
            
        case .call(let addr):
            sp += 1
            stack[sp] = pc
            pc = 0x0FFF & addr
            
        case .se(let vx, let vy):
            if self[vx] == self[vy] {
                try forwardPC()
            }
            
        case .seByte(let vx, let byte):
            if self[vx] == byte {
                try forwardPC()
            }
        
        case .sne(let vx, let vy):
            if(self[vx] != self[vy]) {
                try forwardPC()
            }
            
        case .sneByte(let vx, let byte):
            if self[vx] != byte {
                try forwardPC()
            }
            
        case .ld(let vx, let vy):
            self[vx] = self[vy]
            
        case .ldV(let vx, let byte):
            self[vx] = byte
        
        case .or(let vx, let vy):
            self[vx] = self[vx] | self[vy]
            
        case .and(let vx, let vy):
            self[vx] = self[vx] & self[vy]
            
        case .xor(let vx, let vy):
            self[vx] = self[vx] ^ self[vy]
            
        case .addV(let vx, let byte):
            self[vx] += byte
            
        case .add(let vx, let vy):
            let (sum, overflow) = self[vx].addingReportingOverflow(self[vy])
            self[vx] = sum
            self[.vf] = overflow ? 1 : 0
            
        case .sub(let vx, let vy):
            let (diff, borrow) = self[vx].subtractingReportingOverflow(self[vy])
            self[vx] = diff
            self[.vf] = !borrow ? 1 : 0
            
        case .subn(let vx, let vy):
           let (diff, borrow) = self[vy].subtractingReportingOverflow(self[vx])
           self[vx] = diff
           self[.vf] = !borrow ? 1 : 0
            
        case .shr(let vx):
            // todo - test if moving this after changes anything
            // https://www.reddit.com/r/EmuDev/comments/8cbvz6/chip8_8xy6/dxvwzzx/
            self[.vf] = self[vx] & 1
            self[vx] = self[vx] >> 1
            
        case .shl(let vx):
            // todo - test if moving this after changes anything
            // https://www.reddit.com/r/EmuDev/comments/8cbvz6/chip8_8xy6/dxvwzzx/
            self[.vf] = (self[vx] & 0b10000000) >> 7
            self[vx] = self[vx] << 1
            
        case .ldI(let addr):
            i = addr
            
        case
            
        default:
            throw Chip8Error.fatal("instruction not found \(instruction)")
        }
    }
}
