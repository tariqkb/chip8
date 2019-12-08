import XCTest
@testable import Chip8Lib

final class SubtractTests: XCTestCase {
    
    func testNoBorrow() throws {
        var interp = mockInterpreter(v0: 200, v1: 100)
        
        interp.run(instruction: .subtract(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 100)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testBorrow() throws {
        var interp = mockInterpreter(v0: 100, v1: 200)
        
        interp.run(instruction: .subtract(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 156)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8015), .subtract(.v0, .v1))
    }
}
