import XCTest
@testable import chip8

final class ADDByteTests: XCTestCase {
    
    func testAdds() throws {
        var interp = mockInterpreter(v0: 0x01)
        
        try interp.run(instruction: .addByte(.v0, byte: 0x02))
        
        XCTAssertEqual(interp[.v0], 0x03)
    }
}
