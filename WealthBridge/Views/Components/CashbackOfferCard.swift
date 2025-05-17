//
//  CashbackOffer.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct CashbackOfferCard: View {
    let offer: CashbackOffer

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Merchant info and logo
            HStack {
                // Placeholder for merchant logo
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(offer.merchant.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.blue)
                    )

                VStack(alignment: .leading) {
                    Text(offer.merchant)
                        .font(.headline)
                    Text(offer.category.displayName)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            // Cashback rate
            HStack {
                Text("\(offer.cashbackRate, specifier: "%.1f")%")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Cashback")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Description
            Text(offer.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)

            // Valid until
            Text("Valid until \(offer.validUntil)")
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding()
        .frame(width: 250)
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }
}


// MARK: PREVIEW
struct CashbackOfferCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Single card preview
            CashbackOfferCard(
                offer: CashbackOffer(
                    id: 1,
                    merchant: "Amazon",
                    cashbackRate: 5.0,
                    category: .shopping,
                    logoName: "amazon-logo",
                    description: "Get 5% cashback on all purchases",
                    validUntil: "Dec 31, 2025"
                )
            )
            .padding()
            .previewDisplayName("Amazon Offer")

            // Different offer
            CashbackOfferCard(
                offer: CashbackOffer(
                    id: 2,
                    merchant: "Spotify",
                    cashbackRate: 9.0,
                    category: .entertainment,
                    logoName: "spotify-logo",
                    description: "Earn 9% back on music streaming subscriptions",
                    validUntil: "Dec 31, 2025"
                )
            )
            .padding()
            .previewDisplayName("Spotify Offer")

            // Scrollable horizontal preview
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(1...3, id: \.self) { index in
                        CashbackOfferCard(
                            offer: CashbackOffer(
                                id: index,
                                merchant: "Merchant \(index)",
                                cashbackRate: Double(index * 2),
                                category: .shopping,
                                logoName: "logo-\(index)",
                                description: "Sample description for merchant \(index)",
                                validUntil: "Dec 31, 2025"
                            )
                        )
                    }
                }
                .padding()
            }
            .previewDisplayName("Multiple Offers")
        }
        .previewLayout(.sizeThatFits)
    }
}
