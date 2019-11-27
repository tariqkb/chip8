import XCTest
@testable import chip8

final class ADDTests: XCTestCase {
    
    func testOverflow() throws {
        var interp = mockInterpreter(v0: 200, v1: 100)
        
        try interp.run(instruction: .add(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 44)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testNoOverflow() throws {
        var interp = mockInterpreter(v0: 100, v1: 100)
        
        try interp.run(instruction: .add(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 200)
        XCTAssertEqual(interp[.vf], 0)
    }
}
