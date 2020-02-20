import XCTest
@testable import Chip8Lib

final class SkipIfNotKeypressTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfNotKeypress(.v0))
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xE0A1), .skipIfNotKeypress(.v0))
    }
}
