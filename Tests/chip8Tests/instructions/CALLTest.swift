import XCTest
@testable import chip8

final class CALLTests: XCTestCase {
    
    func testHappyPath() throws {
        let interp = mockInterpreter(pc: 0x000A, sp: 1, stack: mockStack([0x0001, 0x0002]))
        
        try interp.run(instruction: .call(addr: 0x000F))
        
        XCTAssertEqual(interp.topstack, 0x000A)
        XCTAssertEqual(interp.sp, 2)
        XCTAssertEqual(interp.pc, 0x000F)
    }

}
