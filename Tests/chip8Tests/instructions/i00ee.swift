import XCTest
@testable import chip8

final class i00eeTests: XCTestCase {
    
    func test_setsPC() {
        let cpu = mockCPU(pc: 0)
        
        XCTAssertEqual(cpu.registers.pc, 0x0000)
    }
    
    func test_setsProgramCounter() {
        let cpu = mockCPU(pc: 0)
        
        cpu.run(instruction: .i1nnn(0x0ABC))
        
        XCTAssertEqual(cpu.registers.pc, 0x0ABC)
    }
    
    func test_shouldOnlyUseLast12BitsForAddr() {
        let cpu = mockCPU(pc: 0)
        
        cpu.run(instruction: .i1nnn(0xFFFF))
        
        XCTAssertEqual(cpu.registers.pc, 0x0FFF)
    }

}
