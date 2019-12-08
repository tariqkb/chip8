import XCTest
@testable import Chip8Lib

final class LoadWithIntTests: XCTestCase {
    
    func testSetsByte() throws {
        var interp = mockInterpreter(v0: 0x01)
        
        interp.run(instruction: .loadWithInt(.v0, 0x02))
        
        XCTAssertEqual(interp[.v0], 0x02)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x6011), .loadWithInt(.v0, 0x11))
    }
}
