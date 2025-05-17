//
//  Investment.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

//MARK: -BACK-END
// Models/InvestmentModels.swift

//import Foundation
//
//struct Portfolio: Identifiable, Codable {
//    let id: String
//    let totalValue: Double
//    let dayChange: Double
//    let dayChangePercentage: Double
//    let totalGain: Double
//    let totalGainPercentage: Double
//    let holdings: [Investment]
//    let cash: Double
//}
//
//struct Investment: Identifiable, Codable {
//    let id: String
//    let symbol: String
//    let name: String
//    let type: InvestmentType
//    let shares: Double
//    let averageCost: Double
//    let currentPrice: Double
//    let value: Double
//    let dayChange: Double
//    let dayChangePercentage: Double
//    let totalGain: Double
//    let totalGainPercentage: Double
//
//    enum InvestmentType: String, Codable {
//        case stock = "STOCK"
//        case etf = "ETF"
//        case mutualFund = "MUTUAL_FUND"
//        case bond = "BOND"
//        case crypto = "CRYPTO"
//        case other = "OTHER"
//    }
//}
//
//struct InvestmentDataPoint: Codable {
//    let date: Date
//    let price: Double
//    let volume: Int?
//}
//
//struct MarketData: Identifiable, Codable {
//    let id: String
//    let symbol: String
//    let name: String
//    let price: Double
//    let change: Double
//    let changePercentage: Double
//    let marketCap: Double?
//    let volume: Int?
//    let high52Week: Double?
//    let low52Week: Double?
//}
//
//struct InvestmentOrder: Codable {
//    let symbol: String
//    let action: OrderAction
//    let quantity: Double
//    let orderType: OrderType
//    let timeInForce: TimeInForce
//    let limitPrice: Double?
//    let stopPrice: Double?
//
//    enum OrderAction: String, Codable {
//        case buy = "BUY"
//        case sell = "SELL"
//    }
//
//    enum OrderType: String, Codable {
//        case market = "MARKET"
//        case limit = "LIMIT"
//        case stop = "STOP"
//        case stopLimit = "STOP_LIMIT"
//    }
//
//    enum TimeInForce: String, Codable {
//        case day = "DAY"
//        case goodTilCanceled = "GTC"
//        case immediateOrCancel = "IOC"
//        case fillOrKill = "FOK"
//    }
//}
//
//struct OrderConfirmation: Identifiable, Codable {
//    let id: String
//    let orderTime: Date
//    let order: InvestmentOrder
//    let status: OrderStatus
//    let estimatedCommission: Double?
//    let estimatedTotal: Double
//
//    enum OrderStatus: String, Codable {
//        case pending = "PENDING"
//        case filled = "FILLED"
//        case partiallyFilled = "PARTIALLY_FILLED"
//        case cancelled = "CANCELLED"
//        case rejected = "REJECTED"
//    }
//}
