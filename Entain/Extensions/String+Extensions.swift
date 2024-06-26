//
//  String+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

extension String {
    /// Adds the provided ``String`` value to the start of this ``String``
    /// - Parameter string: Value to be preprended
    public mutating func prepend(_ string: String) {
        self = "\(string)\(self)"
    }
}
