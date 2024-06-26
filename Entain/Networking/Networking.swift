//
//  Networking.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

enum NetworkError: Error {
    case connection
    case unauthorized
    case notSuccess
    case invalidBody
    case invalidResponseBody
    case invalidURL
}

protocol Networking {
    static func perform<T: Decodable>(request: URLRequest) async throws -> (T?, Data?)
}

extension Networking {
    static func perform<T: Decodable>(request: URLRequest) async throws -> (T?, Data?) {
        let response = try await URLSession.shared.data(for: request)
        guard let httpResponse = response.1 as? HTTPURLResponse else { throw NetworkError.connection }
        let string = response.0.base64EncodedString()
        if (200...299).contains(httpResponse.statusCode) {
            guard let response = try? JSONDecoder().decode(T.self, from: response.0) else { throw NetworkError.invalidResponseBody }
            return (response, nil)
        } else {
            return (nil, response.0)
        }
    }
}
