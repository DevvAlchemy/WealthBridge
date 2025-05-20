//
//  WealthBridgeApp.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// WealthBridgeApp.swift
import SwiftUI

@main
struct WealthBridgeApp: App {
    @StateObject private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}


