//
//  FinancialToolCard.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct FinancialToolCard: View {
    let title: String
    let description: String
    let iconName: String
    let color: Color

    var body: some View {
        HStack(spacing: 15) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)

                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(color)
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }

            Spacer()

            // Arrow
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(12)
    }
}


//MARK: PREVIEWS
struct FinancialToolCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Single tool preview
            FinancialToolCard(
                title: "Credit Builder",
                description: "Build your credit score with our line of credit feature",
                iconName: "creditcard.fill",
                color: .green
            )
            .padding()
            .previewDisplayName("Credit Builder")

            // Different tool
            FinancialToolCard(
                title: "Investment Advisor",
                description: "Get AI-powered investment recommendations based on your portfolio",
                iconName: "chart.line.uptrend.xyaxis",
                color: .purple
            )
            .padding()
            .previewDisplayName("Investment Advisor")

            // Stack of tools
            VStack(spacing: 12) {
                FinancialToolCard(
                    title: "Credit Builder",
                    description: "Build your credit score with our line of credit",
                    iconName: "creditcard.fill",
                    color: .green
                )

                FinancialToolCard(
                    title: "Investment Advisor",
                    description: "Get AI-powered investment recommendations",
                    iconName: "chart.line.uptrend.xyaxis",
                    color: .purple
                )

                FinancialToolCard(
                    title: "Budgeting Assistant",
                    description: "Smart budgeting with automated insights",
                    iconName: "dollarsign.circle.fill",
                    color: .orange
                )
            }
            .padding()
            .previewDisplayName("All Tools")
        }
        .previewLayout(.sizeThatFits)
    }
}
