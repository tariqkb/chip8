import XCTest
@testable import chip8

final class ANDTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0b001101, v1: 0b111000)
        
        try interp.run(instruction: .and(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b001000)
    }
}
