//
//  Transaction.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct Transaction: Identifiable {
    let id: Int
    let title: String
    let date: String
    let amount: Double
    let type: TransactionType

    enum TransactionType {
        case debit
        case credit
    }
}
