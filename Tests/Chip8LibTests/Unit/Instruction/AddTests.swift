import XCTest
@testable import Chip8Lib

final class AddTests: XCTestCase {
    
    func testOverflow() throws {
        let interp = mockInterpreter(v0: 200, v1: 100)
        
        interp.run(instruction: .add(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 44)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testNoOverflow() throws {
        let interp = mockInterpreter(v0: 100, v1: 100)
        
        interp.run(instruction: .add(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 200)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8014), .add(.v0, .v1))
    }
}
