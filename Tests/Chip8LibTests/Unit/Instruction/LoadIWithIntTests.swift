import XCTest
@testable import Chip8Lib

final class loadIWithIntTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(i: 1)
        
        interp.run(instruction: .loadIWithInt(2))
        
        XCTAssertEqual(interp.i, 2)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xA123), .loadIWithInt(0x123))
    }
}
