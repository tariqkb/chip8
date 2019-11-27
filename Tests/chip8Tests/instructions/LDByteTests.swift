import XCTest
@testable import chip8

final class LDByteTests: XCTestCase {
    
    func testSetsByte() throws {
        var interp = mockInterpreter(v0: 0x01)
        
        try interp.run(instruction: .ldByte(.v0, byte: 0x02))
        
        XCTAssertEqual(interp[.v0], 0x02)
    }
}
