import XCTest
@testable import Chip8Lib

final class DrawTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        interp.run(instruction: .draw(.v0, .v1, nib: 1))
        
        XCTAssertEqual(true, false)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xD011), .draw(.v0, .v1, nib: 0x1))
    }
}
