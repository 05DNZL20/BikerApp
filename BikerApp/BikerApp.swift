//
//  BikerAppApp.swift
//  BikerApp
//
//  Created by Safa Şık on 05.02.24.
//

import SwiftUI

@main
struct BikerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Ride.self])
    }
}
