import UInt4

extension Instruction {
    init(rawValue: UInt16) {
        
        switch(nibbles(of: rawValue)) {
        case(0x0, 0x0, 0x0, 0x0):
            self = .noop
        case (0x0, 0x0, 0xE, 0x0):
            self = .clearScreen
        case (0x0, 0x0, 0xE, 0xE):
            self = .returnFromSubroutine
        case let (0x1, k2, k1, k0):
            self = .jump(addr: unnibble(k2, k1, k0))
        case let (0x2, k2, k1, k0):
            self = .call(addr: unnibble(k2, k1, k0))
        case let (0x3, x, k1, k0):
            self = .skipIfEqualsInt(Register(x), unnibble(k1, k0))
        case let (0x4, x, k1, k0):
            self = .skipIfNotEqualsInt(Register(x), unnibble(k1, k0))
        case let (0x5, x, y, 0x0):
            self = .skipIfEquals(Register(x), Register(y))
        case let (0x6, x, k1, k0):
            self = .loadWithInt(Register(x), unnibble(k1, k0))
        case let (0x7, x, k1, k0):
            self = .addWithInt(Register(x), unnibble(k1, k0))
        case let (0x8, x, y, 0x0):
            self = .load(Register(x), Register(y))
        case let (0x8, x, y, 0x1):
            self = .or(Register(x), Register(y))
        case let (0x8, x, y, 0x2):
            self = .and(Register(x), Register(y))
        case let (0x8, x, y, 0x3):
            self = .xor(Register(x), Register(y))
        case let (0x8, x, y, 0x4):
            self = .add(Register(x), Register(y))
        case let (0x8, x, y, 0x5):
            self = .subtract(Register(x), Register(y))
        case let (0x8, x, _, 0x6):
            self = .shiftRight(Register(x))
        case let (0x8, x, y, 0x7):
            self = .subtractFrom(Register(x), Register(y))
        case let (0x8, x, _, 0xE):
            self = .shiftLeft(Register(x))
        case let (0x9, x, y, 0x0):
            self = .skipIfNotEquals(Register(x), Register(y))
        case let (0xA, k2, k1, k0):
            self = .loadIWithInt(unnibble(k2, k1, k0))
        case let (0xB, k2, k1, k0):
            self = .jumpToV0(plus: unnibble(k2, k1, k0))
        case let (0xC, x, k1, k0):
            self = .loadWithRandom(Register(x), bitmask: unnibble(k1, k0))
        case let (0xD, x, y, k0):
            self = .draw(Register(x), Register(y), nib: k0)
        case let (0xE, x, 0x9, 0xE):
            self = .skipIfKeypress(Register(x))
        case let (0xE, x, 0xA, 0x1):
            self = .skipIfNotKeypress(Register(x))
        case let (0xF, x, 0x0, 0x7):
            self = .loadWithDelay(Register(x))
        case let (0xF, x, 0x0, 0xA):
            self = .waitForKeypress(Register(x))
        case let (0xF, x, 0x1, 0x5):
            self = .loadDelayWith(Register(x))
        case let (0xF, x, 0x1, 0x8):
            self = .loadSoundWith(Register(x))
        case let (0xF, x, 0x1, 0xE):
            self = .addIWith(Register(x))
        case let (0xF, x, 0x2, 0x9):
            self = .loadIWithLocationOfSpriteIn(Register(x))
        case let (0xF, x, 0x3, 0x3):
            self = .loadDecimalOf(Register(x))
        case let (0xF, x, 0x5, 0x5):
            self = .loadIntoMemoryV0To(Register(x))
        case let (0xF, x, 0x6, 0x5):
            self = .loadFromMemoryV0To(Register(x))
        default:
            fatalError("can't parse instruction 0x\(String(rawValue, radix: 16))")
        }
    }
    
    var bytes: UInt16 {
        switch self {
        case .noop:
            return 0x0000
        case .clearScreen:
            return 0x00E0
        case .returnFromSubroutine:
            return 0x00EE
        case .jump(let addr):
            return (0x1 << 12) + addr
        case .call(let addr):
            return (0x2 << 12) + addr
//        case .skipIfEqualsInt(let vx, let byte):
//            return UInt16((0x4 << 12) + (vx.rawValue << 8) + byte)
        default:
            return 0
        }
    }
}

func nibble(_ nib: UInt16, from value: UInt16) -> UInt4 {
    UInt4(value >> (nib * 4) & 0xF)
}

func nibbles(of value: UInt16) -> (UInt4, UInt4, UInt4, UInt4) {
    (nibble(3, from: value), nibble(2, from: value), nibble(1, from: value), nibble(0, from: value))
}

func unnibble(_ second: UInt4, _ first: UInt4, _ zeroth: UInt4) -> UInt16 {
    UInt16(second) << 8 + UInt16(first) << 4 + UInt16(zeroth)
}

func unnibble(_ first: UInt4, _ zeroth: UInt4) -> UInt8 {
    UInt8(first) << 4 + UInt8(zeroth)
}
