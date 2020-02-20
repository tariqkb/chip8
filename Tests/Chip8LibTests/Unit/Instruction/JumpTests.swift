import XCTest
@testable import Chip8Lib

final class JumpTests: XCTestCase {
    
    func testProgramCounter() throws {
        let interp = mockInterpreter(pc: 0)
        
        interp.run(instruction: .jump(addr: 0x0ABC))
        
        XCTAssertEqual(interp.pc, 0x0ABC)
    }

    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x1123), .jump(addr: 0x0123))
    }
}
