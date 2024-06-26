//
//  Race.swift
//  Entain
//
//  Created by BS Entain on 25/6/2024.
//

import SwiftUI

struct Race: Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var date: Date
    var color: Color
    var systemImage: String?
    
    init(id: String, name: String, description: String, date: Date, color: Color = .accentColor, systemImage: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.color = color
        self.systemImage = systemImage
    }
}
