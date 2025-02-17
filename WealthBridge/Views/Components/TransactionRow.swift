//
//  TransactionView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// Views/Components/TransactionRow.swift
import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            //Transaction Type Indicator
            Circle()
                .fill(transaction.amount >= 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: transaction.amount >= 0 ? "arrow.down.left" : "arrow.up.right")
                        .foregroundColor(transaction.amount >= 0 ? .green : .red)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Text(transaction.date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(formatAmount(transaction.amount))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(12)
    }

    //recognizing positive amounts and none positive
    private func formatAmount(_ amount: Double) -> String {
        let isPositive = amount >= 0
        return "\(isPositive ? "" : "-")$\(String(format: "%.2f", abs(amount)))"
    }
}
