//
//  SignUpView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31
//

// SignUpView.swift
import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color("BackgroundColor")
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Logo
                        Image("WealthBridgeLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 100)
                            .padding(.top, 30)

                        // Full Name Field
                        CustomTextField(
                            text: $viewModel.fullName,
                            placeholder: "Full Name",
                            icon: "person.fill"
                        )

                        // Email Field
                        CustomTextField(
                            text: $viewModel.email,
                            placeholder: "Email",
                            icon: "envelope.fill"
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)

                        // Password Field
                        CustomSecureField(
                            text: $viewModel.password,
                            placeholder: "Password",
                            icon: "lock.fill"
                        )

                        // Confirm Password Field
                        CustomSecureField(
                            text: $viewModel.confirmPassword,
                            placeholder: "Confirm Password",
                            icon: "lock.fill"
                        )

                        // Password requirements
                        PasswordRequirementsView(password: viewModel.password)

                        // Error Message
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }

                        // Sign Up Button
                        Button(action: {
                            Task {
                                await viewModel.signUp()
                            }
                        }) {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isLoading)

                        // Terms and Conditions
                        Text("By signing up, you agree to our Terms of Service and Privacy Policy")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        // Back to Login
                        Button("Already have an account? Log In") {
                            dismiss()
                        }
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 20)
                }

                // Loading Indicator
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

// Password Requirements View
struct PasswordRequirementsView: View {
    let password: String

    private var hasMinLength: Bool {
        password.count >= 8
    }

    private var hasUppercase: Bool {
        password.contains(where: { $0.isUppercase })
    }

    private var hasNumber: Bool {
        password.contains(where: { $0.isNumber })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            RequirementRow(text: "At least 8 characters", isMet: hasMinLength)
            RequirementRow(text: "Contains an uppercase letter", isMet: hasUppercase)
            RequirementRow(text: "Contains number", isMet: hasNumber)
        }
        .font(.caption)
    }
}

// Requirement Row Component
struct RequirementRow: View {
    let text: String
    let isMet: Bool

    var body: some View {
        HStack {
            Image(systemName: isMet ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isMet ? .green : .gray)
            Text(text)
                .foregroundColor(isMet ? .green : .gray)
        }
    }
}

#Preview {
    SignUpView()
}
