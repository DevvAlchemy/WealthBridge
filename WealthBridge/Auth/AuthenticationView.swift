//
//  authent.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-20.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var showSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.3), Color(red: 0.2, green: 0.3, blue: 0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                // App Logo
                Image("app-logo") // will add app logo here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                // App Name
                Text("WealthBridge")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)

                // Tagline
                Text("Your bridge to financial freedom")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))

                // Login/Signup Form
                if showSignUp {
                    // Sign Up Form
                    VStack(spacing: 15) {
                        TextField("Full Name", text: $name)
                            .textFieldStyle(AuthTextFieldStyle())

                        TextField("Email", text: $email)
                            .textFieldStyle(AuthTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $password)
                            .textFieldStyle(AuthTextFieldStyle())

                        Button(action: {
                            signUp()
                        }) {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        Button("Already have an account? Log In") {
                            showSignUp = false
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                } else {
                    // Login Form
                    VStack(spacing: 15) {
                        TextField("Email", text: $email)
                            .textFieldStyle(AuthTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $password)
                            .textFieldStyle(AuthTextFieldStyle())

                        Button(action: {
                            login()
                        }) {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        Button("Don't have an account? Sign Up") {
                            showSignUp = true
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                }

                Spacer()

                // Skip button
                Button("Skip and explore the app") {
                    authManager.skipAuthentication()
                }
                .foregroundColor(.white.opacity(0.7))
                .padding(.bottom, 40)
            }
            .padding(.top, 60)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both email and password"
            showAlert = true
            return
        }

        authManager.login(email: email, password: password)

        // Check if login failed
        if !authManager.isAuthenticated {
            alertMessage = "Invalid email or password"
            showAlert = true
        }
    }

    private func signUp() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please fill in all fields"
            showAlert = true
            return
        }

        if !email.contains("@") {
            alertMessage = "Please enter a valid email"
            showAlert = true
            return
        }

        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters"
            showAlert = true
            return
        }

        authManager.signUp(email: email, password: password, name: name)
    }
}

// Custom TextField Style
struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(8)
            .foregroundColor(.white)
    }
}
