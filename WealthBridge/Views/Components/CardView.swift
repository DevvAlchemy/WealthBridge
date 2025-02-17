//
//  CardView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-15.
//

// CardView.swift
import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Card Header
            HStack {
                Text(card.type)
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                // Mastercard circles - This creates the overlapping circles logo
                HStack(spacing: -10) {
                    Circle()
                        .fill(Color.red.opacity(0.8))
                        .frame(width: 25, height: 25)
                    Circle()
                        .fill(Color.orange.opacity(0.8))
                        .frame(width: 25, height: 25)
                }
            }

            // Balance Display
            Text("$\(String(format: "%.2f", card.balance))")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()

            // Card Details Section
            HStack {
                // Cardholder Information
                VStack(alignment: .leading) {
                    Text("Card Holder Name")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text(card.holderName)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }

                Spacer()

                // Expiry Date Information
                VStack(alignment: .trailing) {
                    Text("Expiry Date")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text(card.expiryDate)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }

            // Card Number
            Text(card.cardNumber)
                .font(.callout)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(card.color)
        )
    }
}

// Preview provider for testing the component in isolation
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(
            type: "Business",
            balance: 487775.87,
            cardNumber: "**** **** **** 6598",
            holderName: "Stacy Kalala",
            expiryDate: "03/2030",
            color: .orange
        ))
        .padding()
        .background(Color.black)
    }
}
