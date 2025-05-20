//
//  ContentView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        ZStack {
            // Show main app if authenticated or skipped
            if authManager.isAuthenticated || authManager.isSkippedAuth {
                MainTabView()
            } else {
                // Show authentication flow
                AuthenticationView()
            }
        }
    }
}
