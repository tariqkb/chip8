import XCTest
@testable import Chip8Lib

final class WaitForKeypressTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .waitForKeypress(.v0))
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF00A), .waitForKeypress(.v0))
    }
}
