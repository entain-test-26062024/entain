//
//  EntainApp.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import SwiftUI
import Scyther

@main
struct EntainApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                initDependencies()
            }
        }
    }
}

// MARK: - Dependencies
extension EntainApp {
    func initDependencies() {
        initScyther()
    }

    func initScyther() {
        Scyther.instance.start()
    }
}
