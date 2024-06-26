//
//  RaceSummary.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct RaceSummary: Codable {
    let raceID: String
    let raceNumber: Int
    let meetingName: String
    let categoryID: String?
    let advertisedStart: AdvertisedStart

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceNumber = "race_number"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
    }
}
