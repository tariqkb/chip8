import XCTest

import chip8Tests

var tests = [XCTestCaseEntry]()
tests += chip8Tests.allTests()
XCTMain(tests)
