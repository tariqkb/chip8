import XCTest
@testable import chip8

final class i3xkkTests: XCTestCase {
    
    func test_IncrementsV0Equal() {
        let cpu = mockCPU(v0: 0x01, pc: 0x000A)
        
        try! cpu.run(instruction: .i3xkk(0, 0x01))
        
        XCTAssertEqual(cpu.registers.pc, 0x000C)
    }

    func test_notIncrementsV0NotEqual() {
        let cpu = mockCPU(v0: 0x01, pc: 0x000A)
        
        try! cpu.run(instruction: .i3xkk(0, 0x01))
        
        XCTAssertEqual(cpu.registers.pc, 0x000A)
    }
}
