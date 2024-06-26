//
//  HTTPError.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

internal enum HTTPError: Error {
    case formattedError(URLRequest?, Data?)
    case invalidRequestBody
    case invalidResponse
    case invalidURL

    var originatingRequest: URLRequest? {
        switch self {
        case .formattedError(let request, _):
            return request
        default:
            return nil
        }
    }
    
    var underlyingError: NetworkResponse? {
        switch self {
        case .formattedError(_, let data):
            guard let data = data else { return nil }
            return try? JSONDecoder().decode(NetworkResponse.self, from: data)
        default:
            return nil
        }
    }
}
