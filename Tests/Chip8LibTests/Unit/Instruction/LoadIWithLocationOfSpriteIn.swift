import XCTest
@testable import Chip8Lib

final class LoadIWithLocationOfSpriteInTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 0x01)
        
        interp.run(instruction: .loadIWithLocationOfSpriteIn(.v0))
        
        XCTAssertEqual(interp[.v0], 0x1)
        XCTAssertEqual(interp.i, 0x5)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF029), .loadIWithLocationOfSpriteIn(.v0))
    }
}
