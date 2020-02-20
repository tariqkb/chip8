import XCTest
@testable import Chip8Lib

final class LoadDelayWithTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 1, delay: 10)
        
        interp.run(instruction: .loadDelayWith(.v0))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp.delay, 1)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF015), .loadDelayWith(.v0))
    }
}
