//
//  RaceFilter.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import SwiftUI

enum RaceFilter: CaseIterable, Identifiable {
    case greyhound
    case harness
    case horse
    
    var name: LocalizedStringKey {
        switch self {
        case .greyhound:
            return "RACE_FILTER_GREYHOUND"
        case .harness:
            return "RACE_FILTER_HARNESS"
        case .horse:
            return "RACE_FILTER_HORSE"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .greyhound:
            return "dog"
        case .harness:
            return "figure.seated.seatbelt"
        case .horse:
            return "h.circle"
        }
    }
    
    var id: String {
        switch self {
        case .greyhound:
            return "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
        case .harness:
            return "161d9be2-e909-4326-8c2c-35ed71fb460b"
        case .horse:
            return "4a2788f8-e825-4d36-9894-efd4baf1cfae"
        }
    }
    
    var color: Color {
        switch self {
        case .greyhound:
            return .orange
        case .harness:
            return .green
        case .horse:
            return .purple
        }
    }
}
