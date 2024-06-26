//
//  ContentView.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NextToGoView()
                .navigationTitle("NAVIGATION_TITLE")
        }
    }
}

#Preview {
    ContentView()
}
