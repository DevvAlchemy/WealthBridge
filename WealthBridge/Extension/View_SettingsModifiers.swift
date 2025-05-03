//
//  View_SettingsModifiers.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-01.
//

import SwiftUI

extension View {
    func settingsBackground() -> some View {
        self.background(Color(.systemGroupedBackground))
    }

    func settingsListRow() -> some View {
        self.listRowBackground(Color(.secondarySystemGroupedBackground))
    }
}
