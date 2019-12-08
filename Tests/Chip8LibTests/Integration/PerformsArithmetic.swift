import XCTest
@testable import Chip8Lib

final class PerformsArithmeticTests: XCTestCase {
    
    func test() {
        var interpreter = Interpreter()

        interpreter.load(memory: mockMemory(to8BitArray([
            0x6002, // Load v0 with 0x2     | v0=2 v1=0
            0x8100, // Load v1 with v0      | v0=2 v1=2
            0x8014, // Add v0 with v1       | v0=4 v1=2
            0x7005, // Add 0x5 to v0        | v0=9 v1=2
            0x8105, // Subtract v1 from v0  | v0=9 v1=249 vf=0
            0x1FFE, // Terminate
        ])))
        
        interpreter.run()

        XCTAssertEqual(interpreter[.v0], 9)
        XCTAssertEqual(interpreter[.v1], 249)
        XCTAssertEqual(interpreter[.vf], 0)
    }
}

