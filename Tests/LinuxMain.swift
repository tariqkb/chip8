import XCTest

import Chip8Tests

var tests = [XCTestCaseEntry]()
tests += chip8Tests.allTests()
XCTMain(tests)
