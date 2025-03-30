//
//  TransferModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-03-19.
//

import SwiftUI

struct Transfer: Identifiable {
    let id: Int
    let recipient: String
    let amount: Double
    let date: String
    let type: TransferType
    let status: TransferStatus

    enum TransferType {
        case sent
        case requested
    }

    enum TransferStatus {
        case completed
        case pending
        case failed

        var displayText: String {
            switch self {
            case .completed: return "completed"
            case .pending: return "pending"
            case .failed: return "Failed"
            }
        }
    }
}
