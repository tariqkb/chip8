import XCTest
@testable import Chip8Lib

final class LoadIWithLocationOfSpriteInTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .loadIWithLocationOfSpriteIn(.v0))
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF029), .loadIWithLocationOfSpriteIn(.v0))
    }
}
