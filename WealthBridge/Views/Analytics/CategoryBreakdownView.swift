//
//  CategoryBreakdownView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct CategoryBreakdownView: View {
    let expenses: [ExpenseData]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Spending by Category")
                .font(.headline)

            ForEach(categoryTotals.sorted(by: { $0.value > $1.value }), id: \.key) { category, amount in
                CategoryProgressView(
                    category: category,
                    amount: amount,
                    percentage: percentage(for: category)
                )
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }

    // Calculate category totals
    private var categoryTotals: [ExpenseCategory: Double] {
        var totals: [ExpenseCategory: Double] = [:]

        for expense in expenses {
            totals[expense.category, default: 0] += expense.amount
        }

        return totals
    }

    // Calculate total spending
    private var totalSpending: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    // Calculate percentage for a category
    private func percentage(for category: ExpenseCategory) -> Double {
        guard totalSpending > 0 else { return 0 }
        return (categoryTotals[category] ?? 0) / totalSpending * 100
    }
}

struct CategoryProgressView: View {
    let category: ExpenseCategory
    let amount: Double
    let percentage: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack {
                    Image(systemName: category.icon)
                        .foregroundColor(category.color)

                    Text(category.rawValue)
                        .font(.subheadline)
                }

                Spacer()

                Text("$\(amount, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)

                    // Progress
                    Capsule()
                        .fill(category.color)
                        .frame(width: calculateWidth(totalWidth: geometry.size.width), height: 8)
                }
            }
            .frame(height: 8)

            Text("\(percentage, specifier: "%.1f")%")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

    private func calculateWidth(totalWidth: CGFloat) -> CGFloat {
        let result = totalWidth * (CGFloat(percentage) / 100.0)
        return max(10, result) // Ensure at least 10pt width for visibility
    }
}
