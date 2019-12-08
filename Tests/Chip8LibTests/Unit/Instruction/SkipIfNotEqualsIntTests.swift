import XCTest
@testable import Chip8Lib

final class SkipIfNotEqualsIntTests: XCTestCase {
    
    func testIncrementsV0NotEqual() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfNotEqualsInt(.v0, 0x02))
        
        XCTAssertEqual(interp.pc, 0x000E)
    }
    
    func testNotIncrementsV0Equal() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfNotEqualsInt(.v0, 0x01))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }

    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x4011), .skipIfNotEqualsInt(.v0, 0x11))
    }
}
