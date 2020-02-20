import XCTest
@testable import Chip8Lib

final class JumpToV0Tests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 1, v1: 2, pc: 0)
        
        interp.run(instruction: .jumpToV0(plus: 5))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 2)
        XCTAssertEqual(interp.pc, 6)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xB111), .jumpToV0(plus: 0x111))
    }
}
