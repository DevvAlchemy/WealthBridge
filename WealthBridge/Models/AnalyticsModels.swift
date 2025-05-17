//
//  AnalyticsModels.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: - BACK-END CODE


//import Foundation
//
//struct SpendingAnalytics: Codable {
//    let totalSpending: Double
//    let spendingByCategory: [CategorySpending]
//    let spendingTrend: [DateAmount]
//    let previousPeriodComparison: Double  // percentage change
//    let averageDailySpending: Double
//    let topMerchants: [MerchantSpending]
//}
//
//struct IncomeAnalytics: Codable {
//    let totalIncome: Double
//    let incomeBySource: [SourceIncome]
//    let incomeTrend: [DateAmount]
//    let previousPeriodComparison: Double  // percentage change
//}
//
//struct InvestmentAnalytics: Codable {
//    let totalValue: Double
//    let totalGain: Double
//    let totalGainPercentage: Double
//    let performanceTrend: [DateAmount]
//    let assetAllocation: [AssetAllocation]
//    let riskScore: Int  // 1-10 scale
//    let estimatedYearlyReturn: Double
//}
//
//struct BudgetProgress: Codable {
//    let categories: [BudgetCategory]
//    let overallBudget: Budget
//    let savingsGoalProgress: SavingsGoalProgress
//}
//
//struct CategorySpending: Identifiable, Codable {
//    let id: String
//    let category: TransactionCategory
//    let amount: Double
//    let percentage: Double  // of total spending
//    let previousPeriodComparison: Double  // percentage change
//}
//
//struct SourceIncome: Identifiable, Codable {
//    let id: String
//    let source: String
//    let amount: Double
//    let percentage: Double  // of total income
//    let previousPeriodComparison: Double  // percentage change
//}
//
//struct MerchantSpending: Identifiable, Codable {
//    let id: String
//    let merchantId: String
//    let merchantName: String
//    let category: TransactionCategory
//    let amount: Double
//    let transactionCount: Int
//}
//
//struct DateAmount: Codable {
//    let date: Date
//    let amount: Double
//}
//
//struct AssetAllocation: Identifiable, Codable {
//    let id: String
//    let assetClass: String
//    let value: Double
//    let percentage: Double
//}
//
//struct BudgetCategory: Identifiable, Codable {
//    let id: String
//    let category: TransactionCategory
//    let budgeted: Double
//    let spent: Double
//    let remaining: Double
//    let percentage: Double  // percentage spent
//}
//
//struct Budget: Codable {
//    let budgeted: Double
//    let spent: Double
//    let remaining: Double
//    let percentage: Double  // percentage spent
//}
//
//struct SavingsGoalProgress: Identifiable, Codable {
//    let id: String
//    let name: String
//    let target: Double
//    let current: Double
//    let percentage: Double
//    let deadline: Date?
//    let estimatedCompletionDate: Date?
//}
