import XCTest
@testable import Chip8Lib

final class AndTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 0b001101, v1: 0b111000)
        
        interp.run(instruction: .and(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b001000)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8012), .and(.v0, .v1))
    }
}
