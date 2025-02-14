//
//  LoginViewModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-10.
//

// LoginViewModel.swift

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoading = false

    func login() async {
        guard !email.isEmpty && !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email"
            return
        }

        isLoading = true

        // Here we would typically call an authentication service
        do {
            // Simulate network call
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            // Call your actual authentication service here

            await MainActor.run {
                isLoading = false
                // Handle successful login
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
}

//#Preview {
 //   LoginViewModel()
//}
