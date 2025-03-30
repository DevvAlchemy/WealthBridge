//
//  TransferRow.swift
//  WealthBridge
//
//  Created by Royal K on 2025-03-19.
//
//
import SwiftUI

struct TransferRow: View {
    //property
    let transfer: Transfer

    var body: some View {
        HStack(spacing: 15) {
            statusIcon

            //transfer details
            VStack (alignment: .leading, spacing: 4) {
                Text(transfer.recipient)
                    .font(.system(size: 16, weight: .medium))

                HStack {
                    Text(transfer.type == .sent ? "Sent" : "Resquested")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(".")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Text(transfer.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()

            //amount
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(transfer.amount, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(transfer.type == .sent ? .red: .green)

                Text(transfer.status.displayText)
                    .font(.caption)
                    .foregroundColor(statusColor)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 2)
                    .background(statusColor.opacity(0.2))
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(12)
    }

    //computed properties
    private var statusIcon: some View {
        ZStack{
            Circle()
                .fill(statusColor.opacity(0.2))
                .frame(width: 40, height: 40)

            Image(systemName: statusIconName)
                .foregroundColor(statusColor)
        }
    }

    private var statusColor: Color {
        switch transfer.status {
        case .completed:
            return .green
        case .pending:
            return .orange
        case .failed:
            return .red
        }
    }

    private var statusIconName: String {
        switch transfer.status {
        case .completed:
            return "checkmark"
        case .pending:
            return "clock"
        case .failed:
            return "exclamationmark.triangle"
        }
    }
}

