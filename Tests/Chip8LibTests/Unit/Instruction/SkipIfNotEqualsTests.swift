import XCTest
@testable import Chip8Lib

final class SkipIfNotEqualsTests: XCTestCase {
    
    func testSkipsWhenNotEqual() throws {
        let interp = mockInterpreter(v0: 0, v1: 1, pc: 0x0000)
        
        interp.run(instruction: .skipIfNotEquals(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0)
        XCTAssertEqual(interp[.v1], 1)
        XCTAssertEqual(interp.pc, 0x0004)
    }
    
    func testDoesNotSkipsWhenEqual() throws {
        let interp = mockInterpreter(v0: 1, v1: 1, pc: 0x0000)
        
        interp.run(instruction: .skipIfNotEquals(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 1)
        XCTAssertEqual(interp.pc, 0x0002)
    }

    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x9010), .skipIfNotEquals(.v0, .v1))
    }
}
