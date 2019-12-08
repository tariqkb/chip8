import XCTest
@testable import Chip8Lib

final class ShiftLeftTests: XCTestCase {
    
    func testNoMSB() throws {
        var interp = mockInterpreter(v0: 0b011, vf: 1)
        
        interp.run(instruction: .shiftLeft(.v0))
        
        XCTAssertEqual(interp[.v0], 0b110)
        XCTAssertEqual(interp[.vf], 0)
    }
    
    func testWithMSB() throws {
        var interp = mockInterpreter(v0: 0b10000001, vf: 0)
        
        interp.run(instruction: .shiftLeft(.v0))
        
        XCTAssertEqual(interp[.v0], 0b00000010)
        XCTAssertEqual(interp[.vf], 1)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x800E), .shiftLeft(.v0))
    }
}
