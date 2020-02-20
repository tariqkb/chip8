import XCTest
@testable import Chip8Lib

final class SubtractFromTests: XCTestCase {
    
    func testNoBorrow() throws {
        let interp = mockInterpreter(v0: 200, v1: 100, vf: 1)
        
        interp.run(instruction: .subtractFrom(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 156)
        XCTAssertEqual(interp[.v1], 100)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testBorrow() throws {
        let interp = mockInterpreter(v0: 100, v1: 200, vf: 0)
        
        interp.run(instruction: .subtractFrom(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 100)
        XCTAssertEqual(interp[.v1], 200)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8017), .subtractFrom(.v0, .v1))
    }
}
