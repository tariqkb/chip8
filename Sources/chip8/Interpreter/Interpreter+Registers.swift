enum Register: Hashable {
    case v0
    case v1
    case vf
}

extension Interpreter {
    subscript(_ register: Register) -> UInt8 {
        get {
            guard let value = self.v[register] else {
                fatalError("register \(register) not initialized")
            }
            return value
        }
        set(newValue) {
            self.v[register] = newValue
        }
    }
    
    var topstack: UInt16 {
        get {
            self.stack[self.sp]
        }
    }
    
    mutating func forwardPC() throws {
        self.pc += 2
        // todo - remove hard coded value
        if pc > 4096 {
            throw Chip8Error.pcOutOfBounds(pc: pc)
        }
    }
}

