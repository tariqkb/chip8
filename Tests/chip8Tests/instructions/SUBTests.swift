import XCTest
@testable import chip8

final class SUBTests: XCTestCase {
    
    func testNoBorrow() throws {
        var interp = mockInterpreter(v0: 200, v1: 100)
        
        try interp.run(instruction: .sub(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 100)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testBorrow() throws {
        var interp = mockInterpreter(v0: 100, v1: 200)
        
        try interp.run(instruction: .sub(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 156)
        XCTAssertEqual(interp[.vf], 0)
    }
}
