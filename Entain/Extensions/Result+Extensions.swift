//
//  Result+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

public extension Swift.Result where Success: Encodable {
    /// Checks for success and returns a nullable type T
    /// - Returns: Nulalble value cast to T
    func value<T>() -> T? {
        switch self {
        case .success(let success):
            return success as? T
        case .failure:
            return nil
        }
    }
    
    /// Inidicates whether or not the ``Result`` is a success.
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
}
