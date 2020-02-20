import XCTest
@testable import Chip8Lib

final class ClearScreenTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 0, v1: 0, displayWidth: 8, displayHeight: 1)
        interp.display = [[1,1,1,1,1,1,1,1]]

        interp.run(instruction: .clearScreen)
        
        XCTAssertEqual(interp.display, [[0,0,0,0,0,0,0,0]])
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x00e0), .clearScreen)
    }
}
