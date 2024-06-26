//
//  MockedResponseType.swift
//  EntainTests
//
//  Created by BS Entain on 25/6/2024.
//

import Foundation

enum MockedResponseType {
    case null
    case error
    case empty
    case data(count: Int)
}
