//
//  DateExtensionsTests.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import XCTest
@testable import Entain

class DateExtensionsTests: XCTestCase {
    func testInitUnixTime() {
        let timestamp: Int = 814406400 // 23 October 1995
        let value = Date(unixTime: timestamp)
        XCTAssertEqual(Calendar.current.component(.day, from: value), 23)
        XCTAssertEqual(Calendar.current.component(.month, from: value), 10)
        XCTAssertEqual(Calendar.current.component(.year, from: value), 1995)
    }
    
    func testUnitsOf() {
        let date = Date(unixTime: 814406400)  // 23 October 1995
        let referenceDate = Date(unixTime: 1719313217) // 25 Jun 2024
        let value = date.unitsOf(.year, since: referenceDate) // 28 whole years have passed
        XCTAssertEqual(value, 28)
    }
}
