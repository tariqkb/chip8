import XCTest
@testable import Chip8Lib

final class DrawTests: XCTestCase {
    
    func test() throws {
        let memory = mockMemory([0b10000000, 0b01000000])
        let interp = mockInterpreter(v0: 0, v1: 0, i: 0x200, memory: memory,
                                     displayWidth: 8, displayHeight: 2)
        
        interp.run(instruction: .draw(.v0, .v1, nib: 2))
                
        XCTAssertEqual(interp.display, [[1,0,0,0,0,0,0,0], [0,1,0,0,0,0,0,0]])
        XCTAssertEqual(interp[.v0], 0)
        XCTAssertEqual(interp[.v1], 0)
        XCTAssertEqual(interp[.vf], 0)
        XCTAssertEqual(interp.i, 0x200)
        XCTAssertEqual(interp.memory, memory)
    }
    
    func testWrapX() throws {
        let memory = mockMemory([0b00000001])
        let interp = mockInterpreter(v0: 1, v1: 0, i: 0x200, memory: memory,
                                    displayWidth: 8, displayHeight: 1)
       
        interp.run(instruction: .draw(.v0, .v1, nib: 1))
               
        XCTAssertEqual(interp.display, [[1,0,0,0,0,0,0,0]])
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 0)
        XCTAssertEqual(interp[.vf], 0)
        XCTAssertEqual(interp.i, 0x200)
        XCTAssertEqual(interp.memory, memory)
    }
    
    func testWrapY() throws {
        let memory = mockMemory([0b10000000])
        let interp = mockInterpreter(v0: 0, v1: 2, i: 0x200, memory: memory,
                                     displayWidth: 8, displayHeight: 2)
       
        interp.run(instruction: .draw(.v0, .v1, nib: 1))
       
        XCTAssertEqual(interp.display, [[1,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]])
        XCTAssertEqual(interp[.v0], 0)
        XCTAssertEqual(interp[.v1], 2)
        XCTAssertEqual(interp[.vf], 0)
        XCTAssertEqual(interp.i, 0x200)
        XCTAssertEqual(interp.memory, memory)
   }
    
    func testCollision() throws {
        let memory = mockMemory([0b10000000])
        let interp = mockInterpreter(v0: 0, v1: 0, i: 0x200, memory: memory,
                                     displayWidth: 8, displayHeight: 1)
       
        interp.run(instruction: .draw(.v0, .v1, nib: 1))
        interp.run(instruction: .draw(.v0, .v1, nib: 1))
       
        XCTAssertEqual(interp.display, [[0,0,0,0,0,0,0,0]])
        XCTAssertEqual(interp[.v0], 0)
        XCTAssertEqual(interp[.v1], 0)
        XCTAssertEqual(interp[.vf], 1)
        XCTAssertEqual(interp.i, 0x200)
        XCTAssertEqual(interp.memory, memory)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xD011), .draw(.v0, .v1, nib: 0x1))
    }
}
