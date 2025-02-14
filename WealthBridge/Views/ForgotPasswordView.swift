//
//  ForgotPasswordView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-02.
//

// ForgotPasswordView.swift

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 24) {
                    // Header text
                    Text("Reset Password")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    Text("Enter your email address and we'll send you instructions to reset your password.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    // Email field
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundColor(.gray)

                        TextField("Enter your email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .padding(.horizontal)

                    // Error message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    // Submit button
                    Button(action: {
                        Task {
                            await viewModel.resetPassword()
                        }
                    }) {
                        Text("Send Reset Link")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.isLoading)

                    Spacer()
                }

                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
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

// ForgotPasswordViewModel
class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var errorMessage = ""
    @Published var isLoading = false

    func resetPassword() async {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }

        isLoading = true

        do {
            
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)

            await MainActor.run {
                isLoading = false
                // Handle success (navigate to confirmation screen or show success message)
            }
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = "Failed to send reset link. Please try again."
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// Preview Provider
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
