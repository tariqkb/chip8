import XCTest
@testable import Chip8Lib

final class NoopTests: XCTestCase {
    
    func test() {
        let interp = mockInterpreter(v0: 0x1)
        
        interp.run(instruction: .noop)
        
        XCTAssertEqual(interp[.v0], 0x1)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x0000), .noop)
    }
}
