import XCTest
@testable import Chip8Lib

final class AddIWithTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 1, i: 5)
        
        interp.run(instruction: .addIWith(.v0))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp.i, 6)
    }
 
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF01E), .addIWith(.v0))
    }
}
