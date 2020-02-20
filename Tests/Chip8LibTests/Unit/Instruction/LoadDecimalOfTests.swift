import XCTest
@testable import Chip8Lib

final class LoadDecimalOfTests: XCTestCase {
    
    func test3Digits() throws {
        let interp = mockInterpreter(v0: 255, i: 0x201)
        
        interp.run(instruction: .loadDecimalOf(.v0))
        
        XCTAssertEqual(interp[.v0], 255)
        XCTAssertEqual(interp.i, 0x201)
        XCTAssertTrue(interp.memory.elementsEqual(mockMemory([0, 2, 5, 5])))
    }
    
    func test2Digits() throws {
        let interp = mockInterpreter(v0: 25, i: 0x201)
        
        interp.run(instruction: .loadDecimalOf(.v0))
        
        XCTAssertEqual(interp[.v0], 25)
        XCTAssertEqual(interp.i, 0x201)
        XCTAssertTrue(interp.memory.elementsEqual(mockMemory([0, 0, 2, 5])))
    }
    
    func test1Digit() throws {
        let interp = mockInterpreter(v0: 2, i: 0x201)
        
        interp.run(instruction: .loadDecimalOf(.v0))
        
        XCTAssertEqual(interp[.v0], 2)
        XCTAssertEqual(interp.i, 0x201)
        XCTAssertTrue(interp.memory.elementsEqual(mockMemory([0, 0, 0, 2])))
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF033), .loadDecimalOf(.v0))
    }
}
