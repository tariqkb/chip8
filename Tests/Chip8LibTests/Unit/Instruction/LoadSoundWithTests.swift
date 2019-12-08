import XCTest
@testable import Chip8Lib

final class LoadSoundWithTests: XCTestCase {
    
    func test() throws {
        var interp = mockInterpreter(v0: 1, sound: 10)
        
        interp.run(instruction: .loadSoundWith(.v0))
        
        XCTAssertEqual(interp[.v0], 1)
        XCTAssertEqual(interp.sound, 1)
    }
    
    func testParse() {
        XCTAssertEqual(Instruction(rawValue: 0xF018), .loadSoundWith(.v0))
    }
}
