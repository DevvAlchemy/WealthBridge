//
//  AuthenticationService.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// MARK: -BACK-END CODE FOR DATA


//import Foundation
//
//class AuthenticationServiceImpl: AuthenticationService {
//    private let networkService: NetworkService
//    private var authToken: String?
//    private(set) var currentUser: User?
//
//    var isAuthenticated: Bool {
//        authToken != nil && currentUser != nil
//    }
//
//    init(networkService: NetworkService) {
//        self.networkService = networkService
//    }
//
//    func signIn(email: String, password: String) async throws -> User {
//        let endpoint = Endpoint(
//            path: "auth/signin",
//            method: .post,
//            parameters: [
//                "email": email,
//                "password": password
//            ]
//        )
//
//        let response: AuthResponse = try await networkService.request(endpoint)
//        self.authToken = response.token
//        self.currentUser = response.user
//
//        // Store token securely
//        try saveToken(response.token)
//
//        return response.user
//    }
//
//    func signUp(userData: UserRegistrationData) async throws -> User {
//        let endpoint = Endpoint(
//            path: "auth/signup",
//            method: .post,
//            parameters: [
//                "email": userData.email,
//                "password": userData.password,
//                "firstName": userData.firstName,
//                "lastName": userData.lastName,
//                "phoneNumber": userData.phoneNumber as Any,
//                "dateOfBirth": ISO8601DateFormatter().string(from: userData.dateOfBirth)
//            ]
//        )
//
//        let response: AuthResponse = try await networkService.request(endpoint)
//        self.authToken = response.token
//        self.currentUser = response.user
//
//        // Store token securely
//        try saveToken(response.token)
//
//        return response.user
//    }
//
//    func signOut() async throws {
//        // Clear stored token
//        try removeToken()
//
//        // Clear memory
//        self.authToken = nil
//        self.currentUser = nil
//    }
//
//    func resetPassword(email: String) async throws {
//        let endpoint = Endpoint(
//            path: "auth/reset-password",
//            method: .post,
//            parameters: ["email": email]
//        )
//
//        let _: EmptyResponse = try await networkService.request(endpoint)
//    }
//
//    func verifyCode(email: String, code: String) async throws -> Bool {
//        let endpoint = Endpoint(
//            path: "auth/verify-code",
//            method: .post,
//            parameters: [
//                "email": email,
//                "code": code
//            ]
//        )
//
//        let response: VerificationResponse = try await networkService.request(endpoint)
//        return response.isValid
//    }
//
//    // MARK: - Helper Methods
//
//    private func saveToken(_ token: String) throws {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "authToken",
//            kSecValueData as String: token.data(using: .utf8)!,
//            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
//        ]
//
//        // Delete any existing item
//        SecItemDelete(query as CFDictionary)
//
//        // Add the new item
//        let status = SecItemAdd(query as CFDictionary, nil)
//        guard status == errSecSuccess else {
//            throw KeychainError.unhandledError(status: status)
//        }
//    }
//
//    private func retrieveToken() throws -> String? {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "authToken",
//            kSecReturnData as String: true,
//            kSecMatchLimit as String: kSecMatchLimitOne
//        ]
//
//        var dataTypeRef: AnyObject?
//        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
//
//        if status == errSecSuccess {
//            if let data = dataTypeRef as? Data, let token = String(data: data, encoding: .utf8) {
//                return token
//            }
//        }
//
//        return nil
//    }
//
//    private func removeToken() throws {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: "authToken"
//        ]
//
//        let status = SecItemDelete(query as CFDictionary)
//        guard status == errSecSuccess || status == errSecItemNotFound else {
//            throw KeychainError.unhandledError(status: status)
//        }
//    }
//}
//
//// Models for authentication responses
//private struct AuthResponse: Codable {
//    let token: String
//    let user: User
//}
//
//private struct VerificationResponse: Codable {
//    let isValid: Bool
//}
//
//private struct EmptyResponse: Codable {}
//
//enum KeychainError: Error {
//    case unhandledError(status: OSStatus)
//}
