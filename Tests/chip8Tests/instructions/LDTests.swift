import XCTest
@testable import chip8

final class LDTests: XCTestCase {
    
    func testSets() throws {
        var interp = mockInterpreter(v0: 0x01, v1: 0x02)
        
        try interp.run(instruction: .ld(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0x02)
    }
}
