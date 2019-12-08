import XCTest
@testable import Chip8Lib

final class LoadWithDelayTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 1, delay: 2)
        
        interp.run(instruction: .loadWithDelay(.v0))
        
        XCTAssertEqual(interp[.v0], 2)
        XCTAssertEqual(interp.delay, 2)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF007), .loadWithDelay(.v0))
    }
}
