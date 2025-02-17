//
//  Card.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let type: String  //Business or Premium card
    let balance: Double
    let cardNumber: String
    let holderName: String
    let expiryDate: String
    let color: Color

}


