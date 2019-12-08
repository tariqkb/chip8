import XCTest
@testable import Chip8Lib

final class SkipIfEqualsTest: XCTestCase {
    
    func testIncrementsEqual() throws {
        var interp = mockInterpreter(v0: 0x01, v1: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfEquals(.v0, .v1))
        
        XCTAssertEqual(interp.pc, 0x000E)
    }

    func testNotIncrementsNotEqual() throws {
        var interp = mockInterpreter(v0: 0x01, v1: 0x02, pc: 0x000A)
        
        interp.run(instruction: .skipIfEquals(.v0, .v1))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x5010), .skipIfEquals(.v0, .v1))
    }
}
