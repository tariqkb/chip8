import XCTest
@testable import chip8

final class RETTests: XCTestCase {
    
    func testSetsPCAndDecrementsSP() throws {
        let interp = mockInterpreter(pc: 0, sp: 1, stack: [0x0001, 0x0002])
    
        let topStackAddr = interp.topstack
        
        try interp.run(instruction: .ret)
        
        XCTAssertEqual(interp.pc, topStackAddr)
        XCTAssertEqual(interp.sp, 0)
    }

}
