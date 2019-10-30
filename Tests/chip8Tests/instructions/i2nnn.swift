import XCTest
@testable import chip8

final class i2nnnTests: XCTestCase {
    
    func test_happyPath() {
        let cpu = mockCPU(pc: 0x000A, sp: 1, stack: mockStack([0x0001, 0x0002]))
        
        cpu.run(instruction: .i2nnn(0x000F))
        
        XCTAssertEqual(cpu.registers.topstack, 0x000A)
        XCTAssertEqual(cpu.registers.sp, 2)
        XCTAssertEqual(cpu.registers.pc, 0x000F)
    }

}
