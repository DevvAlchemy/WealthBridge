//
//  NotificationsSettingsView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-01.
//

import SwiftUI

// Views/NotificationsSettingsView.swift
struct NotificationsSettingsView: View {
    @Binding var isEnabled: Bool

    var body: some View {
        Form {
            Toggle("Enable Notifications", isOn: $isEnabled)

            if isEnabled {
                Section(header: Text("Notification Types")) {
                    Toggle("Market Alerts", isOn: .constant(true))
                    Toggle("Portfolio Updates", isOn: .constant(true))
                    Toggle("Newsletters", isOn: .constant(false))
                    Toggle("testing",isOn: .constant(true))
                }

                Section(header: Text("Notification Frequency")) {
                    Picker("Frequency", selection: .constant("Immediate")) {
                        Text("Immediate").tag("Immediate")
                        Text("Daily Digest").tag("Daily")
                        Text("Weekly Summary").tag("Weekly")
                    }
                }
            }

        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//#Preview {
//    NotificationsSettingsView()
//}
//
