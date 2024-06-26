//
//  MockNextToGoRepository.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import Foundation
@testable import Entain

class MockNextToGoRepository: NextToGoRepository {
    // MARK: - Data
    var responseType: MockedResponseType

    // MARK: - Lifecycle
    init(responseType: MockedResponseType) {
        self.responseType = responseType
    }

    // MARK: - Overrides
    override func getRaces(forCategory category: String? = nil, count: Int = 5) async -> NetworkResponse? {
        switch responseType {
        case .null:
            return nil
        case .error:
            return errorResponse
        case .empty:
            return emptyResponse
        case .data(let count):
            return successResponse(count: count)
        }
    }
}

// MARK: - Mocking
private extension MockNextToGoRepository {
    var errorResponse: NetworkResponse {
        return NetworkResponse(status: 400, data: nil, message: "Error")
    }

    var emptyResponse: NetworkResponse {
        return NetworkResponse(status: 200, data: NetworkResponseData(raceSummaries: [:]), message: "Success")
    }

    func successResponse(count: Int) -> NetworkResponse {
        let previousRace = RaceSummary(raceID: "SOME_PEVIOUS_ID",
                                       raceNumber: 23,
                                       meetingName: "SOME_MEETING_NAME_\(Int.random(in: 0...999))",
                                       categoryID: "SOME_CATEGORY_ID_1",
                                       advertisedStart: AdvertisedStart(seconds: 814406400)) // 23 October 1995

        let futureRace = RaceSummary(raceID: "SOME_FUTURE_ID",
                                     raceNumber: 25,
                                     meetingName: "SOME_MEETING_NAME_\(Int.random(in: 0...999))",
                                     categoryID: "SOME_CATEGORY_ID_2",
                                     advertisedStart: AdvertisedStart(seconds: 4086028800)) // 25 June 2099

        let upcomingRace = RaceSummary(raceID: "SOME_UPCOMING_ID",
                                       raceNumber: 24,
                                       meetingName: "SOME_MEETING_NAME_\(Int.random(in: 0...999))",
                                       categoryID: "SOME_CATEGORY_ID_3",
                                       advertisedStart: AdvertisedStart(seconds: 2539728000)) // 25 June 2050

        var values: [String: RaceSummary] = [:]
        values["SOME_PEVIOUS_ID"] = previousRace
        values["SOME_FUTURE_ID"] = futureRace
        values["SOME_UPCOMING_ID"] = upcomingRace

        if values.count < count {
            for i in 1...count {
                let value = RaceSummary(raceID: "SOME_UPCOMING_ID_\(i)",
                                               raceNumber: i,
                                               meetingName: "SOME_MEETING_NAME_\(Int.random(in: 0...999))",
                                               categoryID: "SOME_CATEGORY_ID_\(i)",
                                               advertisedStart: AdvertisedStart(seconds: Int(floor(Date.now.timeIntervalSince1970 * 1000)))) // 25 June 2050
                values["SOME_RANDOM_ID_\(i)"] = value
            }
        }

        let responseData = NetworkResponseData(raceSummaries: values)

        return NetworkResponse(status: 200, data: responseData, message: "Success")
    }
}
