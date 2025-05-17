//
//  OffersModels.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// MARK: - BACK-END  code 

// Models/OffersModels.swift
//
//import Foundation
//
//struct CashbackOffer: Identifiable, Codable {
//    let id: String
//    let merchant: String
//    let merchantLogoUrl: URL?
//    let description: String
//    let cashbackRate: Double
//    let category: OfferCategory
//    let minPurchase: Double?
//    let maxCashback: Double?
//    let expiryDate: Date?
//    let terms: String?
//    let isActivated: Bool
//
//    enum OfferCategory: String, Codable, CaseIterable {
//        case shopping = "SHOPPING"
//        case dining = "DINING"
//        case travel = "TRAVEL"
//        case entertainment = "ENTERTAINMENT"
//        case groceries = "GROCERIES"
//        case services = "SERVICES"
//        case other = "OTHER"
//
//        var displayName: String {
//            switch self {
//            case .shopping: return "Shopping"
//            case .dining: return "Dining"
//            case .travel: return "Travel"
//            case .entertainment: return "Entertainment"
//            case .groceries: return "Groceries"
//            case .services: return "Services"
//            case .other: return "Other"
//            }
//        }
//    }
//}
//
//struct SubscriptionPlan: Identifiable, Codable {
//    let id: String
//    let name: String
//    let price: Double
//    let billingCycle: BillingCycle
//    let features: [PlanFeature]
//    let maxCashbackRate: Double
//    let coverBalance: Double?
//
//    enum BillingCycle: String, Codable {
//        case monthly = "MONTHLY"
//        case yearly = "YEARLY"
//    }
//
//    struct PlanFeature: Identifiable, Codable {
//        let id: String
//        let description: String
//        let isHighlighted: Bool
//    }
//}
//
//struct ActivationResult: Codable {
//    let success: Bool
//    let message: String?
//    let offer: CashbackOffer?
//}
//
//struct SubscriptionConfirmation: Codable {
//    let subscriptionId: String
//    let plan: SubscriptionPlan
//    let startDate: Date
//    let nextBillingDate: Date
//    let paymentMethod: String
//}
