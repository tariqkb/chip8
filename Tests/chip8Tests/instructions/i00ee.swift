import XCTest
@testable import chip8

final class i00eeTests: XCTestCase {
    
    func test_setsPCAndDecrementsSP() {
        let cpu = mockCPU(pc: 0, sp: 1, stack: [0x0001, 0x0002])
    
        let topStackAddr = cpu.registers.stack[cpu.registers.sp]
        
        cpu.run(instruction: .i00ee)
        
        XCTAssertEqual(cpu.registers.pc, topStackAddr)
        XCTAssertEqual(cpu.registers.sp, 0)
    }

}
