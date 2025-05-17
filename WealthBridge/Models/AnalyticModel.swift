//
//  AnalyticModel.swift
//  WealthBridge
//
//

import Foundation
import SwiftUICore
import SwiftUI

// MARK: - Time Period Selection
enum TimePeriod: String, CaseIterable, Identifiable {
    case week = "Week"
    case month = "Month"
    case quarter = "Quarter"
    case year = "Year"
    case all = "All Time"

    var id: String { self.rawValue }
}

// MARK: - Expense Category
enum ExpenseCategory: String, CaseIterable, Identifiable {
    case housing = "Housing"
    case transport = "Transport"
    case food = "Food"
    case utilities = "Utilities"
    case healthcare = "Healthcare"
    case entertainment = "Entertainment"
    case shopping = "Shopping"
    case other = "Other"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .housing: return "house.fill"
        case .transport: return "car.fill"
        case .food: return "fork.knife"
        case .utilities: return "bolt.fill"
        case .healthcare: return "heart.fill"
        case .entertainment: return "tv.fill"
        case .shopping: return "bag.fill"
        case .other: return "ellipsis.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .housing: return .blue
        case .transport: return .green
        case .food: return .orange
        case .utilities: return .purple
        case .healthcare: return .red
        case .entertainment: return .pink
        case .shopping: return .yellow
        case .other: return .gray
        }
    }
}

// MARK: - Transaction Data
struct ExpenseData: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
    let category: ExpenseCategory

    init(date: Date, amount: Double, category: ExpenseCategory) {
        self.date = date
        self.amount = amount
        self.category = category
    }

    // Convenience initializer with string date (yyyy-MM-dd)
//    init(dateString: String, amount: Double, category: ExpenseCategory) {
//        let formatter = DateFormatter()
//        formatter.DateFormat = "yyyy-MM-dd"
//        self.date = formatter.date(from: dateString) ?? Date()
//        self.amount = amount
//        self.category = category
//    }

    init(dateString: String, amount: Double, category: ExpenseCategory) {
        // Skip date parsing for now
        self.date = Date()
        self.amount = amount
        self.category = category
    }
}

// MARK: - Income Data
struct IncomeData: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
    let source: String

    init(date: Date, amount: Double, source: String) {
        self.date = date
        self.amount = amount
        self.source = source
    }

//     Convenience initializer with string date (yyyy-MM-dd)
    init(dateString: String, amount: Double, source: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = formatter.date(from: dateString) ?? Date()
        self.amount = amount
        self.source = source
    }
//
//    init(dateString: String, amount: Double, category: ExpenseCategory) {
//        // Create a fresh formatter
//        let dateFormatter = Foundation.DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        // Parse the date
//        if let parsedDate = dateFormatter.date(from: dateString) {
//            self.date = parsedDate
//        } else {
//            self.date = Date()
//        }
//
//        self.amount = amount
//        self.category = category
//    }
}

// MARK: - Investment Performance
struct InvestmentData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double

    init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }

    // Convenience initializer with string date (yyyy-MM-dd)
    init(dateString: String, value: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = formatter.date(from: dateString) ?? Date()
        self.value = value
    }
}

// MARK: - Sample Data Generator
class AnalyticsDataProvider {
    static func getSampleExpenses() -> [ExpenseData] {
        let today = Date()
        let calendar = Calendar.current

        var expenses: [ExpenseData] = []

        // Generate 3 months of data
        for dayOffset in 0..<90 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) {
                // Generate 1-3 expenses per day
                let expenseCount = Int.random(in: 1...3)

                for _ in 0..<expenseCount {
                    let amount = Double.random(in: 5...150)
                    let categoryIndex = Int.random(in: 0..<ExpenseCategory.allCases.count)
                    let category = ExpenseCategory.allCases[categoryIndex]

                    expenses.append(ExpenseData(date: date, amount: amount, category: category))
                }
            }
        }

        return expenses
    }

    static func getSampleIncome() -> [IncomeData] {
        let today = Date()
        let calendar = Calendar.current

        var incomeData: [IncomeData] = []

        // Generate biweekly salary for 6 months
        for weekOffset in 0..<26 {
            if let date = calendar.date(byAdding: .day, value: -weekOffset * 14, to: today) {
                let amount = 2000.0 + Double.random(in: -100...100)  // Slight variation
                incomeData.append(IncomeData(date: date, amount: amount, source: "Salary"))
            }
        }

        // Add some random additional income
        for monthOffset in 0..<6 {
            if let date = calendar.date(byAdding: .month, value: -monthOffset, to: today) {
                let amount = Double.random(in: 100...500)
                incomeData.append(IncomeData(date: date, amount: amount, source: "Side Gig"))
            }
        }

        return incomeData
    }

    static func getSampleInvestments() -> [InvestmentData] {
        let today = Date()
        let calendar = Calendar.current

        var investmentData: [InvestmentData] = []
        var previousValue = 10000.0  // Starting investment

        // Generate daily data for 6 months
        for dayOffset in 0..<180 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) {
                // Random daily fluctuation between -2% and +2%
                let change = previousValue * Double.random(in: -0.02...0.02)
                previousValue += change

                investmentData.append(InvestmentData(date: date, value: previousValue))
            }
        }

        // Sort by date (oldest first)
        return investmentData.sorted(by: { $0.date < $1.date })
    }
}
