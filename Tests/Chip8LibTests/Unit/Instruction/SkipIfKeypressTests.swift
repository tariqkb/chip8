import XCTest
@testable import Chip8Lib

final class SkipIfKeypressTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .skipIfKeypress(.v0))
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xE09E), .skipIfKeypress(.v0))
    }
}
