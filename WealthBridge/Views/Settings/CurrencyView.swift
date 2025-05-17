//
//  CurrencyView.swift
//  WealthBridge
//
//

import SwiftUI

struct CurrencyView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCurrency: UserProfile.Currency

    var body: some View {
        List {
            ForEach(UserProfile.Currency.allCases) { currency in
                Button(action: {
                    selectedCurrency = currency
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("\(currency.symbol) \(currency.rawValue)")
                            .font(.headline)

                        Text("- \(currency.fullName)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Spacer()

                        if currency == selectedCurrency {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle("Select Currency")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrencyView(selectedCurrency: .constant(.usd))
        }
    }
}
