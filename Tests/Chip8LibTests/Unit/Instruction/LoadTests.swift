import XCTest
@testable import Chip8Lib

final class LoadTests: XCTestCase {
    
    func testSets() throws {
        let interp = mockInterpreter(v0: 0x01, v1: 0x02)
        
        interp.run(instruction: .load(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0x02)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x8010), .load(.v0, .v1))
    }
}
