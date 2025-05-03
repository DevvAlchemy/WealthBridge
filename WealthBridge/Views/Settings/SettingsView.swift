//
//  SettingView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct SettingsView: View {
    @State private var isNotificationsEnabled = true
    @State private var selectedCurrency = "USD"
    @State private var isDarkModeEnabled = false

    var body: some View {
        NavigationStack {
            List {
                // User profile section
                Section {
                    HStack(spacing:16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Stacy Kalala")
                                .font(.headline)
                            Text("Premium Member")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()

                        Button(action: {}) {
                            Text("Edit")
                                .font(.subheadline)
                        }
                    }
                    .padding(.vertical, 8)
                }

                //App setting
                Section(header: Text("App Settings")) {
                    ForEach(
                        SettingsOption.allCases
                            .filter { option in option != .about
                                && option != .help }) { option in
                                    NavigationLink(
                                        destination: destinationView(for: option)) {
                                            SettingsRowView(option: option)
                                        }
                                }
                }
                // Support Section
                Section(header: Text("Support")) {
                    ForEach(SettingsOption.allCases.filter { option in
                        option == .about || option == .help
                    }) { option in
                        NavigationLink(destination: destinationView(for: option)) {
                            SettingsRowView(option: option)
                        }
                    }
                }

                // App Version
                Section {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(Bundle.main.appVersion)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private func destinationView(for option: SettingsOption) -> some View {
        switch option {
        case .notifications:
            NotificationsSettingsView(isEnabled: $isNotificationsEnabled)
        case .currency:
            CurrencySettingsView(selectedCurrency: $selectedCurrency)
        case .security:
            SecuritySettingsView()
        case .appearance:
            AppearanceSettingsView(isDarkModeEnabled: $isDarkModeEnabled)
        case .help:
            HelpView()
        case .about:
            AboutView()
        }
    }
}

#Preview {
    SettingsView()
}
