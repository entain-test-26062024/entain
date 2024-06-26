//
//  TimeRepresentation.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

/// Dictionary of string values representing prefix/suffix values at past and future points in time.
struct TimeRepresentationAccessibilityStrings {
    var futurePrefix: String?
    var futureSuffix: String?
    var pastPrefix: String?
    var pastSuffix: String?
}

/// Object representing minutes and seconds which also provides accessibility and formatting helpers.
struct TimeRepresentation: CustomStringConvertible {
    var seconds = 0
    var minutes = 0

    /// Human-readable string value representing minutes and seconds `e.g. 05:10`
    var description: String {
        var value: String = ""
        let absMinutes = abs(minutes)
        let absSeconds = abs(seconds)
        value = String(format: "%02d:%02d", absMinutes, absSeconds)
        if minutes < 0 || seconds < 0 { value.prepend("-") }
        return value
    }

    /// Voice-Over friendly string value representing minutes and seconds `e.g. 5 minutes and 10 seconds`
    var accessibilityDescription: String {
        var value: String = ""
        let absMinutes = abs(minutes)
        let absSeconds = abs(seconds)
        value = String(format: "%02d minutes and %02d seconds", absMinutes, absSeconds)
        return value
    }
}

// MARK: - Convenience Extensions
extension Int {
    /// `TimeRepresentation` value representing this integer value as human-perceivable minutes and seconds.
    var timeRepresentation: TimeRepresentation {
        var seconds = self
        var minutes = 0
        if seconds >= 60 || seconds < 0 {
            minutes = Int(seconds / 60)
            seconds = seconds - (minutes * 60)
        }
        return TimeRepresentation(seconds: seconds, minutes: minutes)
    }
}
