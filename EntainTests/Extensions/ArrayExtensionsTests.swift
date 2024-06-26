//
//  ArrayExtensionsTests.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import XCTest
@testable import Entain

class ArrayExtensionsTests: XCTestCase {
    func testIsNotEmptyIsTrue() {
        let array: [String] = ["a", "b"]
        let value = array.isNotEmpty
        XCTAssertTrue(value)
    }
    
    func testIsNotEmptyIsFalse() {
        let array: [String] = []
        let value = array.isNotEmpty
        XCTAssertFalse(value)
    }
}
