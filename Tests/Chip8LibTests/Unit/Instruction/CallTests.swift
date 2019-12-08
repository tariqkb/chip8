import XCTest
@testable import Chip8Lib

final class CallTests: XCTestCase {
    
    func testHappyPath() throws {
        var interp = mockInterpreter(pc: 0x000A, sp: 1, stack: mockStack([0x0001, 0x0002]))
        
        interp.run(instruction: .call(addr: 0x000F))
        
        XCTAssertEqual(interp.sp, 2)
        XCTAssertEqual(interp.pc, 0x000F)
        XCTAssertTrue(interp.stack.elementsEqual(mockStack([0x0001, 0x0002, 0x000A])), "\(interp.stack) != \(mockStack([0x0001, 0x0002, 0x000A]))")
    }

    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0x2123), .call(addr: 0x0123))
    }
}
