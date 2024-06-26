//
//  StringExtensionsTests.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import Foundation
import XCTest
@testable import Entain

class StringExtensionsTests: XCTestCase {
    func testPrependValue() {
        var value = "SOME_STRING"
        value.prepend("SOME_PREFIX_")
        XCTAssertTrue(value.hasPrefix("SOME_PREFIX_"))
        XCTAssertEqual(value, "SOME_PREFIX_SOME_STRING")
    }
}
