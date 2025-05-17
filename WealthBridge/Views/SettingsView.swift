//
//  SettingsView.swift
//  WealthBridge
//
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @State private var appSettings = AppSettings()
    @State private var userProfile = UserProfile(
        firstName: "Carlito",
        lastName: "Kalala",
        email: "kalala.Gideon@example.com",
        phoneNumber: "+1 (555) 123-4567",
        profileImage: nil,
        dateOfBirth: Date(timeIntervalSince1970: 820454400), // Example date
        address: UserProfile.Address(
            street: "500 Wyandotte St",
            city: "Windsor",
            state: "ON",
            zipCode: "N2K 2A3",
            country: "Canada"
        ),
        preferredCurrency: .usd
    )

    @State private var showProfileView = false
    @State private var showLogoutAlert = false
    @State private var navigateToSection: SettingsSection?
    @State private var navigateToItem: SettingsItem?

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                // Profile header
                profileHeader

                // Settings sections
                ForEach(SettingsSection.allCases) { section in
                    Section(header: Text(section.rawValue)) {
                        ForEach(section.items) { item in
                            settingsRow(for: item, in: section)
                        }
                    }
                }

                // Version info at bottom
                versionFooter
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showProfileView) {
                ProfileView(profile: $userProfile)
            }
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Log Out")) {
                        // Handle logout
                    },
                    secondaryButton: .cancel()
                )
            }
            .background(
                // Navigation links
                Group {
                    NavigationLink(
                        destination: profileDestination,
                        isActive: Binding(
                            get: { navigateToSection != nil },
                            set: { if !$0 { navigateToSection = nil } }
                        )
                    ) {
                        EmptyView()
                    }
                }
            )
        }
    }

    // MARK: - Subviews
    private var profileHeader: some View {
        VStack(spacing: 15) {
            // Profile image
            ZStack {
                Circle()
                    .fill(Color("CardBackground"))
                    .frame(width: 100, height: 100)

                if let profileImage = userProfile.profileImage {
                    Image(profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Text("\(String(userProfile.firstName.prefix(1)))\(String(userProfile.lastName.prefix(1)))")
                        .font(.title)
                        .foregroundColor(.primary)
                }

                Circle()
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 100, height: 100)
            }

            // User info
            VStack(spacing: 5) {
                Text("\(userProfile.firstName) \(userProfile.lastName)")
                    .font(.title3)
                    .fontWeight(.bold)

                Text(userProfile.email)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            // Edit profile button
            Button(action: {
                showProfileView = true
            }) {
                Text("Edit Profile")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }

    private func settingsRow(for item: SettingsItem, in section: SettingsSection) -> some View {
        Group {
            switch item.type {
            case .navigation:
                Button(action: {
                    navigateToSection = section
                    navigateToItem = item
                }) {
                    HStack {
                        Image(systemName: item.icon)
                            .frame(width: 20)

                        Text(item.title)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.primary)

            case .toggle:
                Toggle(isOn: toggleBinding(for: item, in: section)) {
                    HStack {
                        Image(systemName: item.icon)
                            .frame(width: 20)

                        Text(item.title)
                    }
                }

            case .info(let detail):
                HStack {
                    Image(systemName: item.icon)
                        .frame(width: 20)

                    Text(item.title)

                    Spacer()

                    Text(detail)
                        .foregroundColor(.gray)
                }

            case .destructive:
                Button(action: {
                    if item.title == "Logout" {
                        showLogoutAlert = true
                    }
                }) {
                    HStack {
                        Image(systemName: item.icon)
                            .frame(width: 20)

                        Text(item.title)
                    }
                }
                .foregroundColor(.red)
            }
        }
    }

    private var versionFooter: some View {
        VStack(spacing: 5) {
            Text("WealthBridge")
                .font(.subheadline)
                .fontWeight(.bold)

            Text("Version 1.0.0 (Build 2025.01.31)")
                .font(.caption)
                .foregroundColor(.gray)

            Text("© 2025 WealthBridge Financial, Inc.")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    // MARK: - Helper Methods
    private func toggleBinding(for item: SettingsItem, in section: SettingsSection) -> Binding<Bool> {
        switch (section, item.title) {
        case (.preferences, "Dark Mode"):
            return $appSettings.isDarkMode
        case (.security, "Face ID / Touch ID"):
            return $appSettings.useBiometricAuth
        case (.security, "Two-Factor Authentication"):
            return $appSettings.enableTwoFactorAuth
        case (.notifications, "Push Notifications"):
            return $appSettings.notificationPreferences.pushEnabled
        case (.notifications, "Transaction Alerts"):
            return $appSettings.notificationPreferences.transactionAlerts
        case (.notifications, "Marketing Updates"):
            return $appSettings.notificationPreferences.marketingUpdates
        case (.notifications, "Email Notifications"):
            return $appSettings.notificationPreferences.emailNotifications
        default:
            return .constant(false)
        }
    }

    // MARK: - Navigation Destinations
    @ViewBuilder
    private var profileDestination: some View {
        if let navigateToSection = navigateToSection, let navigateToItem = navigateToItem {
            switch (navigateToSection, navigateToItem.title) {
            case (.account, "Profile Information"):
                ProfileView(profile: $userProfile)
            case (.account, "Linked Accounts"):
                LinkedAccountsView()
            case (.account, "Address"):
                AddressView(address: $userProfile.address)
            case (.preferences, "Currency"):
                CurrencyView(selectedCurrency: $userProfile.preferredCurrency)
            case (.preferences, "App Language"):
                LanguageView(selectedLanguage: $appSettings.language)
            case (.preferences, "Default Account"):
                DefaultAccountView()
            case (.security, "Change Password"):
                ChangePasswordView()
            case (.security, "Privacy Settings"):
                PrivacySettingsView()
            case (.help, "FAQs"):
                FAQView()
            case (.help, "Contact Support"):
                ContactSupportView()
            case (.help, "Report a Problem"):
                ReportProblemView()
            case (.help, "Terms & Conditions"):
                TermsView()
            case (.about, "Legal Information"):
                LegalInformationView()
            case (.about, "Privacy Policy"):
                PrivacyPolicyView()
            case (.about, "Rate the App"):
                RateAppView()
            default:
                Text("Not implemented yet")
                    .foregroundColor(.secondary)
            }
        } else {
            Text("Select a setting")
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
