//
//  Auth.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-20.
//

// AuthManager.swift
import SwiftUI

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isSkippedAuth = false
    @Published var currentUser: User? = nil

    func login(email: String, password: String) {
        // Simple mock authentication
        // In a real app, you would validate against stored credentials
        if email.contains("@") && password.count >= 6 {
            let user = User(id: "user123", name: "Stacy Kalala", email: email)
            currentUser = user
            isAuthenticated = true
        }
    }

    func signUp(email: String, password: String, name: String) {
        // Mock sign up
        let user = User(id: "user123", name: name, email: email)
        currentUser = user
        isAuthenticated = true
    }

    func skipAuthentication() {
        // Allow user to explore the app without authentication
        isSkippedAuth = true
    }

    func signOut() {
        isAuthenticated = false
        isSkippedAuth = false
        currentUser = nil
    }
}

// Simple User model
struct User {
    let id: String
    let name: String
    let email: String
}
