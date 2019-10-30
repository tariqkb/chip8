@testable import chip8

func mockCPU(v0: UInt8 = 0, v1: UInt8 = 0, delay: UInt8 = 0, sound: UInt8 = 0, pc: UInt16 = 0, sp: Int = 0, stack: [UInt16] = [UInt16](repeating: 0, count: 16)) -> CPU {
    let memory = Memory(bytes: 4096)
    let registers = Registers(v0: v0, v1: v1, delay: delay, sound: sound, pc: pc, sp: sp, stack: stack)
    
    return CPU(memory: memory, registers: registers)
}

func mockStack(_ arr: [UInt16]) -> [UInt16] {
    arr + [UInt16](repeating: 0, count: 16 - arr.count)
}
