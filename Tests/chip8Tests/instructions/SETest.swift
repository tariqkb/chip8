import XCTest
@testable import chip8

final class SETest: XCTestCase {
    
    func testIncrementsEqual() throws {
        let interp = mockInterpreter(v0: 0x01, v1: 0x01, pc: 0x000A)
        
        try interp.run(instruction: .se(.v0, .v1))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }

    func testNotIncrementsNotEqual() throws {
        let interp = mockInterpreter(v0: 0x01, v1: 0x02, pc: 0x000A)
        
        try interp.run(instruction: .se(.v0, .v1))
        
        XCTAssertEqual(interp.pc, 0x000A)
    }
}
