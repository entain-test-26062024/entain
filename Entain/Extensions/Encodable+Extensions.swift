//
//  Encodable+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

extension Encodable {
    /// Returns a (nullable) ``Data`` type representation of this value, represented as encoded JSON data.
    var encodedData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
