//
//  BankingModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: - BACK-END CODE

// Models/BankingModels.swift

//
//import Foundation
//
//struct BankAccount: Identifiable, Codable {
//    let id: String
//    let name: String
//    let type: AccountType
//    let balance: Double
//    let currency: UserProfile.Currency
//    let accountNumber: String  // masked except last 4 digits
//    let routingNumber: String? // optional for international accounts
//    let isDefault: Bool
//
//    enum AccountType: String, Codable {
//        case checking = "CHECKING"
//        case savings = "SAVINGS"
//        case investment = "INVESTMENT"
//        case credit = "CREDIT"
//    }
//}
//
//struct Card: Identifiable, Codable {
//    let id: String
//    let type: CardType
//    let lastFour: String
//    let expiryMonth: Int
//    let expiryYear: Int
//    let cardholderName: String
//    let isActive: Bool
//    let dailyLimit: Double?
//    let monthlyLimit: Double?
//
//    var expiryDate: String {
//        String(format: "%02d/%d", expiryMonth, expiryYear % 100)
//    }
//
//    enum CardType: String, Codable {
//        case debit = "DEBIT"
//        case credit = "CREDIT"
//        case virtual = "VIRTUAL"
//        case business = "BUSINESS"
//    }
//}
//
//struct Transaction: Identifiable, Codable {
//    let id: String
//    let date: Date
//    let amount: Double
//    let description: String
//    let category: TransactionCategory
//    let merchant: Merchant?
//    let type: TransactionType
//    let status: TransactionStatus
//    let accountId: String
//
//    enum TransactionType: String, Codable {
//        case debit = "DEBIT"
//        case credit = "CREDIT"
//        case transfer = "TRANSFER"
//        case payment = "PAYMENT"
//        case fee = "FEE"
//        case refund = "REFUND"
//    }
//
//    enum TransactionStatus: String, Codable {
//        case pending = "PENDING"
//        case completed = "COMPLETED"
//        case declined = "DECLINED"
//        case cancelled = "CANCELLED"
//        case failed = "FAILED"
//    }
//}
//
//struct TransactionDetail: Identifiable, Codable {
//    let id: String
//    let transaction: Transaction
//    let location: Location?
//    let notes: String?
//    let attachments: [Attachment]?
//    let tags: [String]?
//
//    struct Location: Codable {
//        let latitude: Double
//        let longitude: Double
//        let address: String?
//        let city: String?
//        let state: String?
//        let country: String?
//    }
//
//    struct Attachment: Identifiable, Codable {
//        let id: String
//        let url: URL
//        let type: AttachmentType
//        let name: String
//
//        enum AttachmentType: String, Codable {
//            case image = "IMAGE"
//            case pdf = "PDF"
//            case receipt = "RECEIPT"
//        }
//    }
//}
//
//struct Merchant: Identifiable, Codable {
//    let id: String
//    let name: String
//    let category: TransactionCategory
//    let logoUrl: URL?
//}
//
//enum TransactionCategory: String, Codable, CaseIterable {
//    case food = "FOOD"
//    case transportation = "TRANSPORTATION"
//    case housing = "HOUSING"
//    case utilities = "UTILITIES"
//    case healthcare = "HEALTHCARE"
//    case entertainment = "ENTERTAINMENT"
//    case shopping = "SHOPPING"
//    case travel = "TRAVEL"
//    case education = "EDUCATION"
//    case personal = "PERSONAL"
//    case income = "INCOME"
//    case transfer = "TRANSFER"
//    case other = "OTHER"
//
//    var displayName: String {
//        switch self {
//        case .food: return "Food & Dining"
//        case .transportation: return "Transportation"
//        case .housing: return "Housing"
//        case .utilities: return "Utilities"
//        case .healthcare: return "Healthcare"
//        case .entertainment: return "Entertainment"
//        case .shopping: return "Shopping"
//        case .travel: return "Travel"
//        case .education: return "Education"
//        case .personal: return "Personal"
//        case .income: return "Income"
//        case .transfer: return "Transfer"
//        case .other: return "Other"
//        }
//    }
//
//    var iconName: String {
//        switch self {
//        case .food: return "fork.knife"
//        case .transportation: return "car.fill"
//        case .housing: return "house.fill"
//        case .utilities: return "bolt.fill"
//        case .healthcare: return "heart.fill"
//        case .entertainment: return "tv.fill"
//        case .shopping: return "bag.fill"
//        case .travel: return "airplane"
//        case .education: return "book.fill"
//        case .personal: return "person.fill"
//        case .income: return "dollarsign.circle.fill"
//        case .transfer: return "arrow.left.arrow.right"
//        case .other: return "ellipsis.circle"
//        }
//    }
//}
