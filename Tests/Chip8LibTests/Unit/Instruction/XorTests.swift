import XCTest
@testable import Chip8Lib

final class XorTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0b00010100, v1: 0b00000101)
        
        interp.run(instruction: .xor(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b00010001)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8013), .xor(.v0, .v1))
    }
}
