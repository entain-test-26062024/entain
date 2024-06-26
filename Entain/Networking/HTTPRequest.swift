//
//  HTTPRequest.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct HTTPRequest {
    init(headers: [String: String] = [:], method: HTTPMethod, baseUrl: String? = nil, path: String, parameters: [String: Any] = [:], timeout: Int = 10) {
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.timeout = timeout
        self.headers = headers
    }
    
    var headers: [String: String]
    var method: HTTPMethod
    var baseUrl: String?
    var path: String
    var parameters: [String: Any]
    var timeout: Int
}
