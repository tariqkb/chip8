import XCTest
@testable import Chip8Lib

final class OrTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 0b001101, v1: 0b110000)
        
        interp.run(instruction: .or(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b111101)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8011), .or(.v0, .v1))
    }
}
