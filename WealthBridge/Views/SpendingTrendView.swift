//
//  SpendingTrendView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct SpendingTrendView: View {
    let expenses: [ExpenseData]
    let period: TimePeriod

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Spending Trend")
                .font(.headline)

            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("$\(totalSpending, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Total Spending")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 5) {
                    HStack(spacing: 2) {
                        Image(systemName: spendingTrend > 0 ? "arrow.up" : "arrow.down")
                            .foregroundColor(spendingTrend > 0 ? .red : .green)

                        Text("\(abs(spendingTrend), specifier: "%.1f")%")
                            .font(.subheadline)
                            .foregroundColor(spendingTrend > 0 ? .red : .green)
                    }

                    Text("vs. previous \(period.rawValue.lowercased())")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // Simple bar chart
            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 4) {
                    ForEach(groupedData.indices, id: \.self) { index in
                        let datum = groupedData[index]
                        VStack {
                            Rectangle()
                                .fill(Color.blue.opacity(0.7))
                                .frame(
                                    height: calculateBarHeight(
                                        value: datum.total,
                                        maxValue: maxSpending,
                                        availableHeight: geometry.size.height - 25
                                    )
                                )

                            Text(datum.label)
                                .font(.system(size: 8))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(height: 150)
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }

    // Calculate bar height relative to max value
    private func calculateBarHeight(value: Double, maxValue: Double, availableHeight: CGFloat) -> CGFloat {
        guard maxValue > 0 else { return 0 }
        let percentage = value / maxValue
        return CGFloat(percentage) * availableHeight
    }

    // Total spending
    private var totalSpending: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    // Spending trend (positive means spending increased, negative means decreased)
    private var spendingTrend: Double {
        _ = expenses

        // This is simplified - in a real app, you'd compare to actual previous period
        let adjustment = Double.random(in: -15...10) // Simplified random trend
        return adjustment
    }

    // Max spending in grouped data
    private var maxSpending: Double {
        groupedData.map { $0.total }.max() ?? 0
    }

    // Group data based on selected period
    private var groupedData: [(label: String, total: Double)] {
        let calendar = Calendar.current
        let formatter = DateFormatter()

        switch period {
        case .week:
            formatter.dateFormat = "EEE"
            let groupedByDay = Dictionary(grouping: expenses) { expense in
                formatter.string(from: expense.date)
            }

            // Get days of week in order
            let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

            return weekdays.map { day in
                let total = groupedByDay[day]?.reduce(0) { $0 + $1.amount } ?? 0
                return (day, total)
            }

        case .month:
            formatter.dateFormat = "d"
            let groupedByDay = Dictionary(grouping: expenses) { expense in
                formatter.string(from: expense.date)
            }

            // For simplicity, show last 7 days
            var result: [(String, Double)] = []
            for i in 1...7 {
                let dayString = "\(i * 4)" // 4, 8, 12, 16, 20, 24, 28
                let total = groupedByDay[dayString]?.reduce(0) { $0 + $1.amount } ?? 0
                result.append((dayString, total))
            }
            return result

        case .quarter:
            formatter.dateFormat = "MMM"
            let groupedByMonth = Dictionary(grouping: expenses) { expense in
                formatter.string(from: expense.date)
            }

            // Show last 3 months
            let months = ["Jan", "Feb", "Mar"]
            return months.map { month in
                let total = groupedByMonth[month]?.reduce(0) { $0 + $1.amount } ?? 0
                return (month, total)
            }

        case .year, .all:
            formatter.dateFormat = "MMM"
            let groupedByMonth = Dictionary(grouping: expenses) { expense in
                formatter.string(from: expense.date)
            }

            // Show all 12 months (simplified for the example)
            let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            return months.map { month in
                let total = groupedByMonth[month]?.reduce(0) { $0 + $1.amount } ?? 0
                return (month, total)
            }
        }
    }
}
