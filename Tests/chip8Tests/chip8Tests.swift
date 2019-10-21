import XCTest
@testable import chip8

final class chip8Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(chip8().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
