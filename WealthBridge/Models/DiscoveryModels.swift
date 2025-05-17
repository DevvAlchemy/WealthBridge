//
//  DiscoveryModels.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

// Models/DiscoveryModels.swift
import SwiftUI

// MARK: - Cashback Offer Model
struct CashbackOffer: Identifiable {
    let id: Int
    let merchant: String
    let cashbackRate: Double
    let category: OfferCategory
    let logoName: String
    let description: String
    let validUntil: String
}

// MARK: - Offer Category Enum
enum OfferCategory: CaseIterable {
    case all
    case shopping
    case entertainment
    case transport
    case food
    case travel

    var displayName: String {
        switch self {
        case .all: return "All"
        case .shopping: return "Shopping"
        case .entertainment: return "Entertainment"
        case .transport: return "Transport"
        case .food: return "Food"
        case .travel: return "Travel"
        }
    }

    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .shopping: return "bag.fill"
        case .entertainment: return "tv.fill"
        case .transport: return "car.fill"
        case .food: return "fork.knife"
        case .travel: return "airplane"
        }
    }
}

// MARK: - Subscription Plan Model
enum SubscriptionPlan: CaseIterable, Identifiable {
    case free
    case premium
    case gold

    var id: String { self.rawValue }

    var name: String {
        switch self {
        case .free: return "Free"
        case .premium: return "Premium"
        case .gold: return "Gold"
        }
    }

    var price: String {
        switch self {
        case .free: return "$0"
        case .premium: return "$4"
        case .gold: return "$12"
        }
    }

    var priceDescription: String {
        switch self {
        case .free: return "Forever"
        case .premium: return "per month"
        case .gold: return "per month"
        }
    }

    var color: Color {
        switch self {
        case .free: return .gray
        case .premium: return .blue
        case .gold: return .yellow
        }
    }

    var maxCashback: String {
        switch self {
        case .free: return "1%"
        case .premium: return "5%"
        case .gold: return "9%"
        }
    }

    var coverBalance: String {
        switch self {
        case .free: return "None"
        case .premium: return "$30"
        case .gold: return "$400"
        }
    }

    var benefits: [String] {
        switch self {
        case .free:
            return [
                "Basic banking features",
                "1% cashback on select merchants",
                "Standard support"
            ]
        case .premium:
            return [
                "All Free features",
                "Up to 5% cashback",
                "Cover balance up to $250",
                "Priority support",
                "Investment insights"
            ]
        case .gold:
            return [
                "All Premium features",
                "Up to 9% cashback",
                "Cover balance up to $400",
                "24/7 dedicated support",
                "Advanced investment tools",
                "Exclusive merchant offers",
                "Financial planning consultation"
            ]
        }
    }
}

extension SubscriptionPlan: RawRepresentable {
    var rawValue: String {
        switch self {
        case .free: return "free"
        case .premium: return "premium"
        case .gold: return "gold"
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "free": self = .free
        case "premium": self = .premium
        case "gold": self = .gold
        default: return nil
        }
    }
}


// MARK: preview at the bottom
struct DiscoveryModels_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview different offer categories
            VStack {
                ForEach(OfferCategory.allCases, id: \.self) { category in
                    HStack {
                        Image(systemName: category.iconName)
                        Text(category.displayName)
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .previewDisplayName("Offer Categories")

            // Preview subscription plan colors
            VStack {
                ForEach([SubscriptionPlan.free, .premium, .gold]) { plan in
                    HStack {
                        Circle()
                            .fill(plan.color)
                            .frame(width: 20, height: 20)
                        Text(plan.name)
                        Spacer()
                        Text(plan.price)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .previewDisplayName("Subscription Plans")
        }
        .previewLayout(.sizeThatFits)
    }
}
