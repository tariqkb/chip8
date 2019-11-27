import XCTest
@testable import chip8

final class SUBNTests: XCTestCase {
    
    func testNoBorrow() throws {
        var interp = mockInterpreter(v0: 200, v1: 100, vf: 1)
        
        try interp.run(instruction: .subn(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 156)
        XCTAssertEqual(interp[.v1], 100)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testBorrow() throws {
        var interp = mockInterpreter(v0: 100, v1: 200, vf: 0)
        
        try interp.run(instruction: .subn(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 100)
        XCTAssertEqual(interp[.v1], 200)
        XCTAssertEqual(interp[.vf], 1)
    }
}
