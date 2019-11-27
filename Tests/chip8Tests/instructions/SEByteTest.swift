import XCTest
@testable import chip8

final class SEByteTests: XCTestCase {
    
    func testIncrementsV0Equal() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        try interp.run(instruction: .seByte(.v0, byte: 0x01))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }

    func testIncrementsV0NotEqual() throws {
        var interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        try interp.run(instruction: .seByte(.v0, byte: 0x02))
        
        XCTAssertEqual(interp.pc, 0x000A)
    }
}
