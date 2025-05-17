//
//  UserModels.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// Models/UserModels.swift
//
//import Foundation
//
//struct User: Identifiable, Codable {
//    let id: String
//    let email: String
//    let firstName: String
//    let lastName: String
//    let createdAt: Date
//    let lastLogin: Date?
//
//    var fullName: String {
//        "\(firstName) \(lastName)"
//    }
//}
//
//struct UserRegistrationData: Codable {
//    let email: String
//    let password: String
//    let firstName: String
//    let lastName: String
//    let phoneNumber: String?
//    let dateOfBirth: Date
//}
//
//struct UserProfile: Codable {
//    var id: String
//    var firstName: String
//    var lastName: String
//    var email: String
//    var phoneNumber: String?
//    var profileImage: URL?
//    var dateOfBirth: Date
//    var address: Address?
//    var preferredCurrency: Currency
//
//    struct Address: Codable {
//        var street: String
//        var city: String
//        var state: String
//        var zipCode: String
//        var country: String
//    }
//
//    enum Currency: String, Codable, CaseIterable {
//        case usd = "USD"
//        case eur = "EUR"
//        case gbp = "GBP"
//        case cad = "CAD"
//        case aud = "AUD"
//        case jpy = "JPY"
//
//        var symbol: String {
//            switch self {
//            case .usd: return "$"
//            case .eur: return "€"
//            case .gbp: return "£"
//            case .cad: return "C$"
//            case .aud: return "A$"
//            case .jpy: return "¥"
//            }
//        }
//    }
//}
//
//struct AppSettings: Codable {
//    var isDarkMode: Bool
//    var useBiometricAuth: Bool
//    var enableTwoFactorAuth: Bool
//    var language: Language
//    var notificationPreferences: NotificationPreferences
//
//    enum Language: String, Codable, CaseIterable {
//        case english = "en"
//        case spanish = "es"
//        case french = "fr"
//        case german = "de"
//        case chinese = "zh"
//    }
//
//    struct NotificationPreferences: Codable {
//        var pushEnabled: Bool
//        var transactionAlerts: Bool
//        var marketingUpdates: Bool
//        var emailNotifications: Bool
//    }
//}
