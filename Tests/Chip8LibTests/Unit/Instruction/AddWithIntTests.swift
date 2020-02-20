import XCTest
@testable import Chip8Lib

final class AddWithIntTests: XCTestCase {
    
    func testAdds() throws {
        let interp = mockInterpreter(v0: 0x01)
        
        interp.run(instruction: .addWithInt(.v0, 0x02))
        
        XCTAssertEqual(interp[.v0], 0x03)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x7001), .addWithInt(.v0, 0x1))
    }
}
