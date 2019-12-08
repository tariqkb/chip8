import XCTest
@testable import Chip8Lib

final class JumpsTests: XCTestCase {
    
    func test() {
        var interpreter = Interpreter()

        interpreter.load(memory: mockMemory(instructions: [
            0x220C, // Call subroutine 1            | 0x200 CALL SUBROUTINE 1
            0x3102, // Skip next if v1 = 2          | 0x202 v0=0 v1=2 v2=3
            0x6001, // Load v0 with 0x1             | 0x204 NOT EXECUTED
            0x3203, // Skip next if v2 = 3          | 0x206 v0=0 v1=2 v2=3
            0x6002, // Load v0 with 0x2             | 0x208 NOT EXECUTED
            0x1FFE, // Terminate                    | 0x20A v0=0 v1=2 v2=3
            0x6102, // Load v1 with 0x2             | 0x20C SUBROUTINE 1 v0=0 v1=2 v2=0
            0x2212, // Call subroutine 2            | 0x20E CALL SUBROUTINE 2
            0x00EE, // Return from subroutine 1     | 0x210 RETURN FROM 1
            0x6203, // Load v2 with 0x3             | 0x212 SUBROUTINE 2 v0=0 v1=2 v2=3
            0x00EE, // Return from subroutine 2     | 0x214 RETURN FROM 2
        ]))
        
        interpreter.run()

        XCTAssertEqual(interpreter[.v0], 0)
        XCTAssertEqual(interpreter[.v1], 2)
        XCTAssertEqual(interpreter[.v2], 3)
    }
}

