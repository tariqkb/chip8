import XCTest
@testable import Chip8Lib

final class ClearScreenTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter()
        
        interp.run(instruction: .clearScreen)
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x00e0), .clearScreen)
    }
}
