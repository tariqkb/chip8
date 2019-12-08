import XCTest
@testable import Chip8Lib

final class LoadWithRandomTests: XCTestCase {
    
    func test0Bitmask() throws {
        var interp = mockInterpreter(v0: 0x01)
        
        interp.run(instruction: .loadWithRandom(.v0, bitmask: 0b00000000))
        
        XCTAssertEqual(interp[.v0], 0)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xC011), .loadWithRandom(.v0, bitmask: 0x11))
    }
}
