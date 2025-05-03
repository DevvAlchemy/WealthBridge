//
//  CurrencySettingsView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-01.
//

import SwiftUI

// Currency Selection and style
struct CurrencySettingsView: View {
    @Binding var selectedCurrency: String

    let currencies = ["CAD","USD", "EUR", "GBP", "JPY", "AUD", "MXN"]

    var body: some View {
        Form {
            Picker("Base Currency", selection: $selectedCurrency) {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency)
                }
            }
            .pickerStyle(.menu)

            Text("Changing your base currency will convert all amounts in the app.")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .navigationTitle("Currency")
        .navigationBarTitleDisplayMode(.inline)
    }
}
