//
//  AnalyticTabView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct AnalyticsView: View {
   
    // MARK: - Properties
    @State private var selectedPeriod: TimePeriod = .month
    @State private var expenseData: [ExpenseData] = AnalyticsDataProvider.getSampleExpenses()
    @State private var incomeData: [IncomeData] = AnalyticsDataProvider.getSampleIncome()
    @State private var investmentData: [InvestmentData] = AnalyticsDataProvider.getSampleInvestments()

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Period selector
                    periodSelector

                    // Financial Snapshot
                    financialSnapshot

                    // Spending Trend
                    SpendingTrendView(expenses: expenseData, period: selectedPeriod)

                    // Income vs Expenses
                    IncomeExpenseComparisonView(
                        incomeData: incomeData,
                        expenseData: expenseData,
                        period: selectedPeriod
                    )

                    // Category Breakdown
                    CategoryBreakdownView(expenses: expenseData)

                    // Investment Performance
                    InvestmentPerformanceView(
                        investmentData: investmentData,
                        period: selectedPeriod
                    )
                }
                .padding()
            }
            .navigationTitle("Analytics")
            .background(Color("backgroundColor").ignoresSafeArea())
        }
    }

    // MARK: - Subviews
    private var periodSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(TimePeriod.allCases) { period in
                    PeriodButton(
                        title: period.rawValue,
                        isSelected: selectedPeriod == period
                    ) {
                        withAnimation {
                            selectedPeriod = period
                        }
                    }
                }
            }
            .padding(.horizontal, 2)
        }
    }

    private var financialSnapshot: some View {
        VStack(spacing: 15) {
            // Balance summaries in a row
            HStack(spacing: 10) {
                // Total Balance
                BalanceSummaryCard(
                    title: "Net Worth",
                    amount: calculateNetWorth(),
                    change: 5.2,
                    color: .blue
                )

                // Monthly Savings
                BalanceSummaryCard(
                    title: "Monthly Savings",
                    amount: calculateMonthlySavings(),
                    change: calculateSavingsRate(),
                    color: .green
                )
            }

            // Weekly spending limit progress
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Weekly Budget")
                        .font(.subheadline)

                    Spacer()

                    Text("$\(weeklySpending, specifier: "%.2f") of $\(weeklyBudget, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 10)

                        // Progress
                        Capsule()
                            .fill(budgetProgressColor)
                            .frame(width: calculateBudgetProgress(width: geometry.size.width), height: 10)
                    }
                }
                .frame(height: 10)

                HStack {
                    Spacer()
                    Text(budgetRemainingText)
                        .font(.caption)
                        .foregroundColor(budgetProgressColor)
                }
            }
            .padding()
            .background(Color("CardBackground"))
            .cornerRadius(16)
        }
    }

    // MARK: - Helper Methods

    private func calculateNetWorth() -> Double {
        // Current investment value
        let investmentValue = investmentData.last?.value ?? 0

        // Last month income minus expenses
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()

        let monthlyIncome = incomeData.filter {
            if let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) {
                return $0.date >= monthAgo
            }
            return false
        }.reduce(0) { $0 + $1.amount }

        let monthlyExpenses = expenseData.filter {
            if let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) {
                return $0.date >= monthAgo
            }
            return false
        }.reduce(0) { $0 + $1.amount }

        // Simplified net worth calculation
        return investmentValue + monthlyIncome - monthlyExpenses
    }

    private func calculateMonthlySavings() -> Double {
        // Calculate income and expenses for the current month
        let today = Date()
        let calendar = Calendar.current

        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) else {
            return 0
        }

        let monthlyIncome = incomeData.filter {
            return $0.date >= startOfMonth
        }.reduce(0) { $0 + $1.amount }

        let monthlyExpenses = expenseData.filter {
            return $0.date >= startOfMonth
        }.reduce(0) { $0 + $1.amount }

        return monthlyIncome - monthlyExpenses
    }

    private func calculateSavingsRate() -> Double {
        let monthlySavings = calculateMonthlySavings()

        let monthlyIncome = incomeData.filter {
            if let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) {
                return $0.date >= monthAgo
            }
            return false
        }.reduce(0) { $0 + $1.amount }

        guard monthlyIncome > 0 else { return 0 }
        return (monthlySavings / monthlyIncome) * 100
    }

    // Weekly budget constants
    private let weeklyBudget: Double = 500

    // Weekly spending calculation
    private var weeklySpending: Double {
        let calendar = Calendar.current
        let today = Date()

        guard let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            return 0
        }

        return expenseData.filter {
            return $0.date >= weekStart
        }.reduce(0) { $0 + $1.amount }
    }

    // Budget progress calculation
    private func calculateBudgetProgress(width: CGFloat) -> CGFloat {
        let percentageUsed = min(weeklySpending / weeklyBudget, 1.0)
        return width * CGFloat(percentageUsed)
    }

    // Budget progress color
    private var budgetProgressColor: Color {
        let percentageUsed = weeklySpending / weeklyBudget

        if percentageUsed < 0.75 {
            return .green
        } else if percentageUsed < 1.0 {
            return .orange
        } else {
            return .red
        }
    }

    // Budget remaining text
        private var budgetRemainingText: String {
            let remaining = weeklyBudget - weeklySpending

            if remaining >= 0 {
                return "$\(String(format: "%.2f", remaining)) left"
            } else {
                return "$\(String(format: "%.2f", abs(remaining))) over budget"
            }
        }
}

// MARK: - Supporting Components

struct PeriodButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .bold : .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue.opacity(0.2) : Color("CardBackground"))
                .foregroundColor(isSelected ? .blue : .primary)
                .cornerRadius(20)
        }
    }
}

struct BalanceSummaryCard: View {
    let title: String
    let amount: Double
    let change: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("$\(amount, specifier: "%.2f")")
                .font(.title3)
                .fontWeight(.bold)

            HStack(spacing: 4) {
                Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                    .font(.caption)

                Text("\(abs(change), specifier: "%.1f")%")
                    .font(.caption)
            }
            .foregroundColor(change >= 0 ? .green : .red)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("CardBackground"))
        .cornerRadius(16)
        .overlay(
            Rectangle()
                .fill(color)
                .frame(width: 4)
                .cornerRadius(4)
            ,
            alignment: .leading
        )
    }
}

// MARK: - Preview
struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
