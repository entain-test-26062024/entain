//
//  TimeRepresentationTests.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import XCTest
@testable import Entain

class TimeRepresentationTests: XCTestCase {
    func testTimeRepresentationForKnownPositiveIntegerLessThanAMinute() {
        let int: Int = 30
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, 0)
        XCTAssertEqual(value.seconds, 30)
        XCTAssertEqual(value.description, "00:30")
        XCTAssertEqual(value.accessibilityDescription, "00 minutes and 30 seconds")
    }
    
    func testTimeRepresentationForKnownPositiveIntegerEqualToAMinute() {
        let int: Int = 60
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, 1)
        XCTAssertEqual(value.seconds, 0)
        XCTAssertEqual(value.description, "01:00")
        XCTAssertEqual(value.accessibilityDescription, "01 minutes and 00 seconds")
    }
    
    func testTimeRepresentationForKnownPositiveIntegerGreaterThanAMinute() {
        let int: Int = 84
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, 1)
        XCTAssertEqual(value.seconds, 24)
        XCTAssertEqual(value.description, "01:24")
        XCTAssertEqual(value.accessibilityDescription, "01 minutes and 24 seconds")
    }
    
    func testTimeRepresentationForKnownNegativeIntegerLessThanAMinute() {
        let int: Int = -30
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, 0)
        XCTAssertEqual(value.seconds, -30)
        XCTAssertEqual(value.description, "-00:30")
        XCTAssertEqual(value.accessibilityDescription, "00 minutes and 30 seconds")
    }
    
    func testTimeRepresentationForKnownNegativeIntegerEqualToAMinute() {
        let int: Int = -60
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, -1)
        XCTAssertEqual(value.seconds, 0)
        XCTAssertEqual(value.description, "-01:00")
        XCTAssertEqual(value.accessibilityDescription, "01 minutes and 00 seconds")
    }
    
    func testTimeRepresentationForKnownnegativeIntegerGreaterThanAMinute() {
        let int: Int = -84
        let value = int.timeRepresentation
        XCTAssertEqual(value.minutes, -1)
        XCTAssertEqual(value.seconds, -24)
        XCTAssertEqual(value.description, "-01:24")
        XCTAssertEqual(value.accessibilityDescription, "01 minutes and 24 seconds")
    }
}
