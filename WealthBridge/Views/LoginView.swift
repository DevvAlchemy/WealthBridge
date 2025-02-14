//
//  LoginView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// LoginView.swift
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showSignUp = false
    @State private var showForgotPassword = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color("BackgroundColor") //  will define this in assets
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Logo
                    Image("WealthBridgeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 100)
                        .padding(.top, 50)

                    // Email Field
                    CustomTextField(
                        text: $viewModel.email,
                        placeholder: "Email",
                        icon: "envelope.fill"
                    )
                    .textInputAutocapitalization(.never)

                    // Password Field
                    CustomSecureField(
                        text: $viewModel.password,
                        placeholder: "Password",
                        icon: "lock.fill"
                    )

                    // Error Message section
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Login Button
                    Button(action: {
                        Task {
                            await viewModel.login()
                        }
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isLoading)

                    // Sign Up section
                    Button("Don't have an account? Sign Up") {
                        showSignUp.toggle()
                    }
                    .foregroundColor(.blue)

                    // Forgot Password section
                    Button("Forgot Password?") {
                        showForgotPassword.toggle()
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)

                // Loading Indicator
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .sheet(isPresented: $showSignUp) {
                SignUpView()
            }
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordView()
            }
        }
    }
}

// Custom TextField Component
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// Custom Secure Field Component
struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            SecureField(placeholder, text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    LoginView()
}
