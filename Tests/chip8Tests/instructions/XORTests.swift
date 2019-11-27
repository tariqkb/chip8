import XCTest
@testable import chip8

final class XORTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 0b00010100, v1: 0b00000101)
        
        try interp.run(instruction: .xor(.v0, .v1))
        
        XCTAssertEqual(interp[.v0], 0b00010001)
    }
}
