//
//  IncomeExpenseComparisonView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct IncomeExpenseComparisonView: View {
    let incomeData: [IncomeData]
    let expenseData: [ExpenseData]
    let period: TimePeriod

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Income vs Expenses")
                .font(.headline)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                        Text("Income: $\(filteredIncome, specifier: "%.2f")")
                            .font(.subheadline)
                    }

                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Expenses: $\(filteredExpenses, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Net: $\(netAmount, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(netAmount >= 0 ? .green : .red)

                    Text(savingsRate >= 0 ? "Saving \(savingsRate, specifier: "%.0f")%" : "Overspending \(abs(savingsRate), specifier: "%.0f")%")
                        .font(.caption)
                        .foregroundColor(savingsRate >= 0 ? .green : .red)
                }
            }

            // Grouped bar chart
            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(monthlyComparison.indices, id: \.self) { index in
                        let data = monthlyComparison[index]

                        VStack(spacing: 0) {
                            // Income bar
                            VStack(spacing: 4) {
                                Rectangle()
                                    .fill(Color.green.opacity(0.7))
                                    .frame(
                                        height: calculateBarHeight(
                                            value: data.income,
                                            maxValue: maxValue,
                                            availableHeight: geometry.size.height - 30
                                        )
                                    )
                            }

                            // Expense bar
                            VStack(spacing: 4) {
                                Rectangle()
                                    .fill(Color.red.opacity(0.7))
                                    .frame(
                                        height: calculateBarHeight(
                                            value: data.expense,
                                            maxValue: maxValue,
                                            availableHeight: geometry.size.height - 30
                                        )
                                    )
                            }

                            Text(data.label)
                                .font(.system(size: 8))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 160)
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }

    // Calculate bar height
    private func calculateBarHeight(value: Double, maxValue: Double, availableHeight: CGFloat) -> CGFloat {
        guard maxValue > 0 else { return 0 }
        let percentage = value / maxValue
        return CGFloat(percentage) * availableHeight
    }

    // Filtered income
    private var filteredIncome: Double {
        guard !incomeData.isEmpty else { return 0 }
        return filterDataByPeriod(incomeData).reduce(0) { $0 + $1.amount }
    }

    // Filtered expenses
    private var filteredExpenses: Double {
        guard !expenseData.isEmpty else { return 0 }
        return filterDataByPeriod(expenseData).reduce(0) { $0 + $1.amount }
    }

    // Net amount (income - expenses)
    private var netAmount: Double {
        filteredIncome - filteredExpenses
    }

    // Savings rate
    private var savingsRate: Double {
        guard filteredIncome > 0 else { return -100 }
        return (netAmount / filteredIncome) * 100
    }

    // Maximum value for chart scaling
    private var maxValue: Double {
        let maxIncome = monthlyComparison.map { $0.income }.max() ?? 0
        let maxExpense = monthlyComparison.map { $0.expense }.max() ?? 0
        return max(maxIncome, maxExpense)
    }

    // Helper to filter income data by period
    private func filterDataByPeriod<T>(_ data: [T]) -> [T] where T: Identifiable {
        guard let lastDate = (data as? [IncomeData])?.last?.date ?? (data as? [ExpenseData])?.last?.date else {
            return []
        }

        let calendar = Calendar.current
        var filteredData: [T] = []

        switch period {
        case .week:
            // Last 7 days
            let weekAgo = calendar.date(byAdding: .day, value: -7, to: lastDate) ?? lastDate
            filteredData = data.filter {
                if let income = $0 as? IncomeData {
                    return income.date >= weekAgo
                } else if let expense = $0 as? ExpenseData {
                    return expense.date >= weekAgo
                }
                return false
            }
        case .month:
            // Last 30 days
            let monthAgo = calendar.date(byAdding: .day, value: -30, to: lastDate) ?? lastDate
            filteredData = data.filter {
                if let income = $0 as? IncomeData {
                    return income.date >= monthAgo
                } else if let expense = $0 as? ExpenseData {
                    return expense.date >= monthAgo
                }
                return false
            }
        case .quarter:
            // Last 90 days
            let quarterAgo = calendar.date(byAdding: .day, value: -90, to: lastDate) ?? lastDate
            filteredData = data.filter {
                if let income = $0 as? IncomeData {
                    return income.date >= quarterAgo
                } else if let expense = $0 as? ExpenseData {
                    return expense.date >= quarterAgo
                }
                return false
            }
        case .year:
            // Last 365 days
            let yearAgo = calendar.date(byAdding: .day, value: -365, to: lastDate) ?? lastDate
            filteredData = data.filter {
                if let income = $0 as? IncomeData {
                    return income.date >= yearAgo
                } else if let expense = $0 as? ExpenseData {
                    return expense.date >= yearAgo
                }
                return false
            }
        case .all:
            filteredData = data
        }

        return filteredData
    }

    // Monthly comparison data
    private var monthlyComparison: [(label: String, income: Double, expense: Double)] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()

        switch period {
        case .week:
            dateFormatter.dateFormat = "EEE"
            let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

            return days.map { day in
                let incomeForDay = incomeData.filter {
                    dateFormatter.string(from: $0.date) == day
                }.reduce(0) { $0 + $1.amount }

                let expenseForDay = expenseData.filter {
                    dateFormatter.string(from: $0.date) == day
                }.reduce(0) { $0 + $1.amount }

                return (day, incomeForDay, expenseForDay)
            }

        case .month:
            // Group by week of month
            return (1...4).map { weekNumber in
                let weekLabel = "Week \(weekNumber)"

                let startDay = (weekNumber - 1) * 7 + 1
                let endDay = min(startDay + 6, 28)

                let incomeForWeek = incomeData.filter { income in
                    let day = calendar.component(.day, from: income.date)
                    return day >= startDay && day <= endDay
                }.reduce(0) { $0 + $1.amount }

                let expenseForWeek = expenseData.filter { expense in
                    let day = calendar.component(.day, from: expense.date)
                    return day >= startDay && day <= endDay
                }.reduce(0) { $0 + $1.amount }

                return (weekLabel, incomeForWeek, expenseForWeek)
            }

        case .quarter, .year, .all:
            dateFormatter.dateFormat = "MMM"
            let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

            // For demo purposes, only show a few months
            let monthsToShow = period == .quarter ? Array(months.prefix(3)) :
                              period == .year ? months :
                              Array(months.suffix(6))

            return monthsToShow.map { month in
                let incomeForMonth = incomeData.filter {
                    dateFormatter.string(from: $0.date) == month
                }.reduce(0) { $0 + $1.amount }

                let expenseForMonth = expenseData.filter {
                    dateFormatter.string(from: $0.date) == month
                }.reduce(0) { $0 + $1.amount }

                return (month, incomeForMonth, expenseForMonth)
            }
        }
    }
}
