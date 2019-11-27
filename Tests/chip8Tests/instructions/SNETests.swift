import XCTest
@testable import chip8

final class SNETests: XCTestCase {
    
    func testSkipsWhenNotEqual() throws {
        var interp = mockInterpreter(v0: 0, v1: 1, pc: 0x0000)
        
        try interp.run(instruction: .sne(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0)
        XCTAssertEqual(interp[.v1], 1)
        XCTAssertEqual(interp.pc, 0x0002)
    }
    
    func testDoesNotSkipsWhenEqual() throws {
        var interp = mockInterpreter(v0: 1, v1: 1, pc: 0x0000)
        
        try interp.run(instruction: .sne(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 1)
        XCTAssertEqual(interp.pc, 0x0000)
    }

}
