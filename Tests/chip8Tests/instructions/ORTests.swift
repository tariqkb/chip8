import XCTest
@testable import chip8

final class ORTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0b001101, v1: 0b110000)
        
        try interp.run(instruction: .or(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b111101)
    }
}
