import XCTest
@testable import Chip8Lib

final class LoadFromMemoryV0ToTests: XCTestCase {
    
    func test() throws {
        let memory = mockMemory([0, 1, 2])
        let interp = mockInterpreter(v0: 0, v1: 0, i: 0x201, memory: memory)
        
        interp.run(instruction: .loadFromMemoryV0To(.v1))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 2)
        XCTAssertEqual(interp.i, 0x201)
        XCTAssertTrue(interp.memory.elementsEqual(memory))
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF065), .loadFromMemoryV0To(.v0))
    }
}
