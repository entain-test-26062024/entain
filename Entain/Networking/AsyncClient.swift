//
//  AsyncClient.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct AsyncClient<T: Decodable>: Networking {
    private static func performRequest(withHeaders headers: [String: String], method: HTTPMethod, baseUrl: String? = nil, path: String, parameters: [String: Any] = [:], body: Encodable? = nil, timeout: Int = 10) async -> (Swift.Result<T, HTTPError>) {
        // Check that we have a valid URL when combined with the specified path and parameters
        guard var url: URL = URL(string: "\(baseUrl ?? Self.baseUrl)\(path)") else { return .failure(.invalidURL) }
        url.appendQueryItems(parameters)

        // Construct request
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(timeout * 1000)

        // Set static headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // Set dynamic headers
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }

        // Set request body ONLY if we're not making a GET request.
        if let body = body, method != .GET {
            guard let data: Data = body.encodedData else { return .failure(.invalidRequestBody) }
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // Attempt request
        guard let response: (body: T?, data: Data?) = try? await perform(request: request) else {
            return .failure(.formattedError(request, nil))
        }
        if let responseBody: T = response.body {
            return .success(responseBody)
        } else {
            return .failure(HTTPError.formattedError(request, response.data))
        }
    }

    @discardableResult static func performRequest(_ request: HTTPRequest, body: Encodable? = nil) async -> Swift.Result<T, HTTPError> {
        return await performRequest(withHeaders: request.headers,
                                    method: request.method,
                                    baseUrl: request.baseUrl,
                                    path: request.path,
                                    parameters: request.parameters,
                                    body: body,
                                    timeout: request.timeout)
    }
}

// MARK: - Data Conveniences
private extension AsyncClient {
    static var baseUrl: String {
        return "https://api.neds.com.au/rest/v1/"
    }
}
