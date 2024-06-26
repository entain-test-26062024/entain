//
//  NetworkResponseData.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct NetworkResponseData: Codable {
    let raceSummaries: [String: RaceSummary]?

    enum CodingKeys: String, CodingKey {
        case raceSummaries = "race_summaries"
    }
}
