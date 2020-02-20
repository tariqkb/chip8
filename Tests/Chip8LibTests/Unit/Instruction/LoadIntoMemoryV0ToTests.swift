import XCTest
@testable import Chip8Lib

final class LoadIntoMemoryV0ToTests: XCTestCase {
    
    func test() throws {
        let interp = mockInterpreter(v0: 1, v1: 2, i: 0x201)
        
        interp.run(instruction: .loadIntoMemoryV0To(.v1))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp[.v1], 2)
        XCTAssertEqual(interp.i, 0x201)
        XCTAssertTrue(interp.memory.elementsEqual(mockMemory([0, 1, 2])))
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF055), .loadIntoMemoryV0To(.v0))
    }
}
