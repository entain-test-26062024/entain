//
//  NextToGoRequests.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct NextToGoRequests {
    static func getNextRaces(count: Int = 5) -> HTTPRequest {
        return HTTPRequest(method: .GET,
                           path: "racing/",
                           parameters: ["method": "nextraces",
                                        "count": count])
    }
}
