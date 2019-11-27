@testable import chip8

func mockInterpreter(v0: UInt8 = 0, v1: UInt8 = 0, vf: UInt8 = 0, i: UInt16 = 0, delay: UInt8 = 0, sound: UInt8 = 0, pc: UInt16 = 0, sp: Int = 0, stack: [UInt16] = [UInt16](repeating: 0, count: 16)) -> Interpreter {
    
    return Interpreter(memory: Memory(bytes: 4096), v0: v0, v1: v1, vf: vf, i: i, delay: delay, sound: sound, pc: pc, sp: sp, stack: stack )
}

func mockStack(_ arr: [UInt16]) -> [UInt16] {
    arr + [UInt16](repeating: 0, count: 16 - arr.count)
}
