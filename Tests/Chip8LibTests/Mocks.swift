@testable import Chip8Lib

func mockInterpreter(v0: UInt8 = 0, v1: UInt8 = 0, vf: UInt8 = 0, i: UInt16 = 0, delay: UInt8 = 0, sound: UInt8 = 0, pc: UInt16 = 0, sp: Int = 0, stack: [UInt16] = [UInt16](repeating: 0, count: 16), memory: [UInt8] = [UInt8](repeating: 0, count: 4096), displayWidth: Int = 64, displayHeight: Int = 32) -> Interpreter {
    
    return Interpreter(memory: memory, v: [.v0: v0, .v1: v1, .vf: vf], i: i, delay: delay, sound: sound, pc: pc, sp: sp, stack: stack, displayWidth: displayWidth, displayHeight: displayHeight)
}

func mockStack(_ arr: [UInt16] = []) -> [UInt16] {
    arr + [UInt16](repeating: 0, count: 16 - arr.count)
}

func mockMemory(_ arr: [UInt8] = []) -> [UInt8] {
    unshiftFontSprites(into: [UInt8](repeating: 0, count: 0x200)  + arr + [UInt8](repeating: 0, count: 4096 - arr.count - 0x200))
}
