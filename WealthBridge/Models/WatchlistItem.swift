//
//  WatchlistItem.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-15.
//

import SwiftUI

struct WatchlistItem: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price:  Double
    let percentageChange: Double
    let type: AssetType

    enum AssetType {
        case stock
        case crypto
    }
}
