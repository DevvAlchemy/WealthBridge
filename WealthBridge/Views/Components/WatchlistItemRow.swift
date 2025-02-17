//
//  WatchlistView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// WatchlistItemRow.swift
import SwiftUI

struct WatchlistItemRow: View {
    let item: WatchlistItem

    var body: some View {
        HStack {
            // Symbol and Name Section
            VStack(alignment: .leading) {
                Text(item.symbol)
                    .font(.headline)
                Text(item.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Price and Change Section
            VStack(alignment: .trailing) {
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.headline)
                Text("\(item.percentageChange > 0 ? "+" : "")\(String(format: "%.2f", item.percentageChange))%")
                    .font(.subheadline)
                    .foregroundColor(item.percentageChange >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(15)
    }
}

// Preview provider for testing the component
struct WatchlistItemRow_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistItemRow(item: WatchlistItem(
            symbol: "AAPL",
            name: "Apple Inc.",
            price: 178.72,
            percentageChange: 2.45,
            type: .stock
        ))
        .padding()
    }
}
