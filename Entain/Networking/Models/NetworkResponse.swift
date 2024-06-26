//
//  NetworkResponse.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

struct NetworkResponse: Codable {
    let status: Int
    let data: NetworkResponseData?
    let message: String

    init(status: Int, data: NetworkResponseData?, message: String) {
        self.status = status
        self.data = data
        self.message = message
    }
}
