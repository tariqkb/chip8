import XCTest
@testable import chip8

final class SHLTests: XCTestCase {
    
    func testNoMSB() throws {
        var interp = mockInterpreter(v0: 0b011, vf: 1)
        
        try interp.run(instruction: .shl(.v0))
        
        XCTAssertEqual(interp[.v0], 0b110)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testWithMSB() throws {
        var interp = mockInterpreter(v0: 0b10000001, vf: 0)
        
        try interp.run(instruction: .shl(.v0))
        
        XCTAssertEqual(interp[.v0], 0b00000010)
        XCTAssertEqual(interp[.vf], 1)
    }
}
