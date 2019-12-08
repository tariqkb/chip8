import XCTest
@testable import Chip8Lib

final class SkipIfEqualsIntTests: XCTestCase {
    
    func testIncrementsV0Equal() {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfEqualsInt(.v0, 0x01))
        
        XCTAssertEqual(interp.pc, 0x000E)
    }

    func testIncrementsV0NotEqual() {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfEqualsInt(.v0, 0x02))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x3011), .skipIfEqualsInt(.v0, 0x11))
    }
}
