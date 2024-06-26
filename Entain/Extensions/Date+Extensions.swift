//
//  Date+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

extension Date {
    /// Initialises a date using a en epoch/unix timestamp
    /// - Parameter unixTime: Unix timestamp
    init(unixTime: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(unixTime))
    }
    
    /// Number of _whole_ units between this date and the reference date
    /// - Parameters:
    ///   - unit: ``Calendar.Component`` value to be passed back
    ///   - toDate: ``Date`` that comparison will be made against
    /// - Returns: An integer representing the number of _WHOLE_ units between two dates
    func unitsOf(_ unit: Calendar.Component, since toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([unit], from: self, to: toDate)
        var value: Int?
        switch unit {
        case .era:
            value = components.era
        case .year:
            value = components.year
        case .month:
            value = components.month
        case .day:
            value = components.day
        case .hour:
            value = components.hour
        case .minute:
            value = components.minute
        case .second:
            value = components.second
        case .weekday:
            value = components.weekday
        case .weekdayOrdinal:
            value = components.weekdayOrdinal
        case .quarter:
            value = components.quarter
        case .weekOfMonth:
            value = components.weekOfMonth
        case .weekOfYear:
            value = components.weekOfYear
        case .yearForWeekOfYear:
            value = components.yearForWeekOfYear
        case .nanosecond:
            value = components.nanosecond
        default:
            break
        }
        return value ?? .max
    }
}
