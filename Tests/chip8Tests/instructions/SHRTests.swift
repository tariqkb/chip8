import XCTest
@testable import chip8

final class SHRTests: XCTestCase {
    
    func testShfitsWith0LSB() throws {
        var interp = mockInterpreter(v0: 0b100, v1: 100)
        
        try interp.run(instruction: .shr(.v0))
        
        XCTAssertEqual(interp[.v0], 0b010)
        XCTAssertEqual(interp[.v1], 100) // Tests current spec doesn't modify vy
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testShiftsWith1LSB() throws {
        var interp = mockInterpreter(v0: 0b101, v1: 100)
        
        try interp.run(instruction: .shr(.v0))
        
        XCTAssertEqual(interp[.v0], 0b010)
        XCTAssertEqual(interp[.v1], 100) // Tests current spec doesn't modify vy
        XCTAssertEqual(interp[.vf], 1)
    }
}
