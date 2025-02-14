//
//  SignUpViewModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-11.
//

// SignUpViewModel.swift
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    @Published var isLoading = false

    func signUp() async {
        // Validate inputs
        guard !fullName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }

        guard isValidPassword(password) else {
            errorMessage = "Password must be at least 8 characters long, contain an uppercase letter and a number"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        isLoading = true

        do {
            // Simulate network call
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            // Call your actual registration service here

            await MainActor.run {
                isLoading = false
                // Handle successful registration
            }
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 &&
        password.contains(where: { $0.isUppercase }) &&
        password.contains(where: { $0.isNumber })
    }
}

