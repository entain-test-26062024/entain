//
//  Array+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

extension Array {
    /// A boolean value indicating if the ``Array`` in question contains one or more elements.
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}
