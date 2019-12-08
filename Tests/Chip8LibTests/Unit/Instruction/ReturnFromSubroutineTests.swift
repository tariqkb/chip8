import XCTest
@testable import Chip8Lib

final class ReturnFromSubroutineTests: XCTestCase {
    
    func testSetsPCAndDecrementsSP() throws {
        var interp = mockInterpreter(pc: 0, sp: 1, stack: mockStack([0x0001, 0x0002]))
    
        interp.run(instruction: .returnFromSubroutine)
        
        XCTAssertEqual(interp.pc, 0x0002)
        XCTAssertEqual(interp.sp, 0)
        XCTAssertTrue(interp.stack.elementsEqual(mockStack([0x0001, 0x0002])))
    }

    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x00EE), .returnFromSubroutine)
    }
}
