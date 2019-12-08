enum ProgramCounterOperation {
    case set(to: UInt16)
    case skip
    case next(from: UInt16? = nil)
}

extension Interpreter {
    
    mutating func run() {
        pc = 0x200
        
        while pc < memory.count {
            print("running \(currentInstruction) at 0x\(String(pc, radix: 16))")
            run(instruction: currentInstruction)
        }
        
        print("terminated")
    }
    
    mutating func run(instruction: Instruction) {
        var pcOperation: ProgramCounterOperation = .next()
        
        switch(instruction) {
        case .noop:
            break
            
        case .clearScreen:
            break
            
        case .returnFromSubroutine:
            pcOperation = .next(from: stack[sp])
            self.sp -= 1
            
        case .jump(let addr):
            pcOperation = .set(to: addr)
            
        case .call(let addr):
            sp += 1
            stack[sp] = pc
            pcOperation = .set(to: addr)
            
        case .skipIfEqualsInt(let vx, let byte):
            if self[vx] == byte {
                pcOperation = .skip
            }
            
        case .skipIfNotEqualsInt(let vx, let byte):
            if self[vx] != byte {
                pcOperation = .skip
            }
            
        case .skipIfEquals(let vx, let vy):
            if self[vx] == self[vy] {
                pcOperation = .skip
            }
        
        case .loadWithInt(let vx, let byte):
            self[vx] = byte
            
        case .addWithInt(let vx, let byte):
            self[vx] += byte
            
        case .load(let vx, let vy):
            self[vx] = self[vy]
            
        case .or(let vx, let vy):
            self[vx] = self[vx] | self[vy]
            
        case .and(let vx, let vy):
            self[vx] = self[vx] & self[vy]
            
        case .xor(let vx, let vy):
            self[vx] = self[vx] ^ self[vy]
            
        case .add(let vx, let vy):
            let (sum, overflow) = self[vx].addingReportingOverflow(self[vy])
            self[vx] = sum
            self[.vf] = overflow ? 1 : 0
            
        case .subtract(let vx, let vy):
            let (diff, borrow) = self[vx].subtractingReportingOverflow(self[vy])
            self[vx] = diff
            self[.vf] = !borrow ? 1 : 0
            
        case .shiftRight(let vx):
            // todo - test if moving this after changes anything
            // https://www.reddit.com/r/EmuDev/comments/8cbvz6/chip8_8xy6/dxvwzzx/
            self[.vf] = self[vx] & 1
            self[vx] = self[vx] >> 1
            
        case .subtractFrom(let vx, let vy):
            let (diff, borrow) = self[vy].subtractingReportingOverflow(self[vx])
            self[vx] = diff
            self[.vf] = !borrow ? 1 : 0
            
        case .shiftLeft(let vx):
            // todo - test if moving this after changes anything
            // https://www.reddit.com/r/EmuDev/comments/8cbvz6/chip8_8xy6/dxvwzzx/
            self[.vf] = (self[vx] & 0b10000000) >> 7
            self[vx] = self[vx] << 1
            
        case .skipIfNotEquals(let vx, let vy):
            if(self[vx] != self[vy]) {
                pcOperation = .skip
            }
            
        case .loadIWithInt(let addr):
            i = addr
        
        case .jumpToV0(let plus):
            pcOperation = .set(to: UInt16(self[.v0]) + plus)
            
        case .loadWithRandom(let vx, let bitmask):
            self[vx] = UInt8.random(in: 0...255) & bitmask
            
        case .draw:
            break
            
        case .skipIfKeypress(let vx):
            break
            
        case .skipIfNotKeypress(let vx):
            break
            
        case .loadWithDelay(let vx):
            self[vx] = delay
            
        case .waitForKeypress(let vx):
            break
            
        case .loadDelayWith(let vx):
            delay = self[vx]
            
        case .loadSoundWith(let vx):
            sound = self[vx]
            
        case .addIWith(let vx):
            i += UInt16(self[vx])
            
        case .loadIWithLocationOfSpriteIn(let vx):
            break
            
        case .loadDecimalOf(let vx):
            let intermediate = self[vx] / 10
            memory[Int(i)] = intermediate / 10
            memory[Int(i + 1)] = intermediate - memory[Int(i)] * 10
            memory[Int(i + 2)] = self[vx] - (intermediate * 10)

        case .loadIntoMemoryV0To(let vx):
            for (index, v) in (.v0...vx).enumerated() {
                memory[Int(i) + index] = self[v]
            }
            
        case .loadFromMemoryV0To(let vx):
            for (index, v) in (.v0...vx).enumerated() {
                self[v] = memory[Int(i) + index]
            }
        }
        
        switch(pcOperation) {
        case .set(let addr):
            pc = addr
        case .skip:
            pc += 4
        case .next(let from):
            pc = (from ?? pc) + 2
        }
        
    }
}
