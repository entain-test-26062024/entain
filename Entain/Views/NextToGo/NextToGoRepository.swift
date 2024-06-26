//
//  NextToGoRepository.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

class NextToGoRepository {
    func getRaces(forCategory category: String? = nil, count: Int = 5) async -> NetworkResponse? {
        let request = NextToGoRequests.getNextRaces(count: count)
        return await AsyncClient<NetworkResponse>.performRequest(request).value()
    }
}
