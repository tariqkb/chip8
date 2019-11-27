import XCTest
@testable import chip8

final class JUMPTests: XCTestCase {
    
    func testPCShouldBe0OnInit() throws {
        let interp = mockInterpreter(pc: 0)
        
        XCTAssertEqual(interp.pc, 0x0000)
    }
    
    func testProgramCounter() throws {
        var interp = mockInterpreter(pc: 0)
        
        try interp.run(instruction: .jump(addr: 0x0ABC))
        
        XCTAssertEqual(interp.pc, 0x0ABC)
    }

}
