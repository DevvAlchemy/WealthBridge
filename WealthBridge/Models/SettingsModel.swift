//
//  SettingsModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

import SwiftUI

// MARK: - Settings Section
enum SettingsSection: String, CaseIterable, Identifiable {
    case account = "Account"
    case preferences = "Preferences"
    case security = "Security"
    case notifications = "Notifications"
    case help = "Help & Support"
    case about = "About"

    var id: String { self.rawValue }

    var systemImageName: String {
        switch self {
        case .account: return "person.circle"
        case .preferences: return "gear"
        case .security: return "lock.shield"
        case .notifications: return "bell"
        case .help: return "questionmark.circle"
        case .about: return "info.circle"
        }
    }

    var items: [SettingsItem] {
        switch self {
        case .account:
            return [
                .init(title: "Profile Information", icon: "person.fill", type: .navigation),
                .init(title: "Linked Accounts", icon: "link", type: .navigation),
                .init(title: "Address", icon: "mappin.and.ellipse", type: .navigation),
                .init(title: "Logout", icon: "arrow.right.square", type: .destructive)
            ]
        case .preferences:
            return [
                .init(title: "Currency", icon: "dollarsign.circle", type: .navigation),
                .init(title: "Dark Mode", icon: "moon.fill", type: .toggle),
                .init(title: "App Language", icon: "globe", type: .navigation),
                .init(title: "Default Account", icon: "creditcard", type: .navigation)
            ]
        case .security:
            return [
                .init(title: "Face ID / Touch ID", icon: "faceid", type: .toggle),
                .init(title: "Change Password", icon: "key", type: .navigation),
                .init(title: "Two-Factor Authentication", icon: "lock.shield", type: .toggle),
                .init(title: "Privacy Settings", icon: "hand.raised", type: .navigation)
            ]
        case .notifications:
            return [
                .init(title: "Push Notifications", icon: "bell.badge", type: .toggle),
                .init(title: "Transaction Alerts", icon: "creditcard.fill", type: .toggle),
                .init(title: "Marketing Updates", icon: "megaphone", type: .toggle),
                .init(title: "Email Notifications", icon: "envelope", type: .toggle)
            ]
        case .help:
            return [
                .init(title: "FAQs", icon: "questionmark.circle", type: .navigation),
                .init(title: "Contact Support", icon: "envelope.badge", type: .navigation),
                .init(title: "Report a Problem", icon: "exclamationmark.triangle", type: .navigation),
                .init(title: "Terms & Conditions", icon: "doc.text", type: .navigation)
            ]
        case .about:
            return [
                .init(title: "App Version", icon: "apps.iphone", type: .info(detail: "1.0.0")),
                .init(title: "Legal Information", icon: "doc.text", type: .navigation),
                .init(title: "Privacy Policy", icon: "hand.raised", type: .navigation),
                .init(title: "Rate the App", icon: "star.fill", type: .navigation)
            ]
        }
    }
}

// MARK: - Settings Item
struct SettingsItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let type: SettingsItemType

    enum SettingsItemType {
        case navigation
        case toggle
        case info(detail: String)
        case destructive
    }
}

// MARK: - User Profile
struct UserProfile {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profileImage: String? // Image name or URL
    var dateOfBirth: Date
    var address: Address
    var preferredCurrency: Currency

    struct Address {
        var street: String
        var city: String
        var state: String
        var zipCode: String
        var country: String
    }

    enum Currency: String, CaseIterable, Identifiable {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
        case cad = "CAD"
        case aud = "AUD"
        case jpy = "JPY"

        var id: String { self.rawValue }
        var symbol: String {
            switch self {
            case .usd: return "$"
            case .eur: return "€"
            case .gbp: return "£"
            case .cad: return "C$"
            case .aud: return "A$"
            case .jpy: return "¥"
            }
        }

        var fullName: String {
            switch self {
            case .usd: return "US Dollar"
            case .eur: return "Euro"
            case .gbp: return "British Pound"
            case .cad: return "Canadian Dollar"
            case .aud: return "Australian Dollar"
            case .jpy: return "Japanese Yen"
            }
        }
    }
}

// MARK: - App Settings
struct AppSettings {
    var isDarkMode: Bool = false
    var useBiometricAuth: Bool = true
    var enableTwoFactorAuth: Bool = false
    var language: Language = .english
    var notificationPreferences: NotificationPreferences = NotificationPreferences()

    enum Language: String, CaseIterable, Identifiable {
        case english = "English"
        case spanish = "Spanish"
        case french = "French"
        case german = "German"
        case chinese = "Chinese"

        var id: String { self.rawValue }
    }

    struct NotificationPreferences {
        var pushEnabled: Bool = true
        var transactionAlerts: Bool = true
        var marketingUpdates: Bool = false
        var emailNotifications: Bool = true
    }
}
