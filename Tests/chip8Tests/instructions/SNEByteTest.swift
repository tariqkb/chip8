import XCTest
@testable import chip8

final class SNEByteTests: XCTestCase {
    
    func testIncrementsV0NotEqual() throws {
        let interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        try interp.run(instruction: .sneByte(.v0, byte: 0x02))
        
        XCTAssertEqual(interp.pc, 0x000C)
    }
    
    func testNotIncrementsV0Equal() throws {
        let interp = mockInterpreter(v0: 0x01, pc: 0x000A)
        
        try interp.run(instruction: .sneByte(.v0, byte: 0x01))
        
        XCTAssertEqual(interp.pc, 0x000A)
    }

}
