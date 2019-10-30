import XCTest
@testable import chip8

final class i4xkkTests: XCTestCase {
    
    func test_incrementsV0NotEqual() {
        let cpu = mockCPU(v0: 0x01, pc: 0x000A)
        
        cpu.run(instruction: .i3xkk(0, 0x02))
        
        XCTAssertEqual(cpu.registers.pc, 0x000C)
    }
    
    func test_notIncrementsV0Equal() {
        let cpu = mockCPU(v0: 0x01, pc: 0x000A)
        
        cpu.run(instruction: .i3xkk(0, 0x01))
        
        XCTAssertEqual(cpu.registers.pc, 0x000A)
    }

}
