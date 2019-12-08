import UInt4

enum Register: Int {
    case v0
    case v1
    case v2
    case v3
    case v4
    case v5
    case v6
    case v7
    case v8
    case v9
    case va
    case vb
    case vc
    case vd
    case ve
    case vf
    
    init(_ nibble: UInt4) {
        guard let reg = Register(rawValue: Int(nibble)) else {
            fatalError()
        }
        self = reg
    }
}

extension Register: Strideable {
    typealias Stride = Int
    
    func distance(to other: Register) -> Int {
        Int(other.rawValue) - self.rawValue
    }
    
    func advanced(by n: Int) -> Register {
        Register(rawValue: self.rawValue + n)!
    }
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
    
    var currentInstruction: Instruction {
        get {
            Instruction(rawValue: UInt16(memory[Int(pc)]) << 8 + UInt16(memory[Int(pc + 1)]))
        }
    }
}

