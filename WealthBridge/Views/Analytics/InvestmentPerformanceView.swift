//
//  InvestmentView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//


import SwiftUI

struct InvestmentPerformanceView: View {
    let investmentData: [InvestmentData]
    let period: TimePeriod

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Investment Performance")
                .font(.headline)

            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("$\(currentValue, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Current Value")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 5) {
                    HStack(spacing: 2) {
                        Image(systemName: percentageChange >= 0 ? "arrow.up" : "arrow.down")
                            .foregroundColor(percentageChange >= 0 ? .green : .red)

                        Text("\(abs(percentageChange), specifier: "%.2f")%")
                            .font(.subheadline)
                            .foregroundColor(percentageChange >= 0 ? .green : .red)
                    }

                    Text(period == .week ? "This week" : period == .month ? "This month" : "This period")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // Line chart
            GeometryReader { geometry in
                ZStack {
                    // Y-axis grid lines
                    VStack(spacing: 0) {
                        ForEach(0..<5) { i in
                            Spacer()
                            Divider()
                                .background(Color.gray.opacity(0.2))
                        }
                        Spacer()
                    }

                    // Line and gradient
                    if !filteredData.isEmpty {
                        // Area under the line
                        Path { path in
                            let points = calculatePoints(
                                data: filteredData,
                                size: geometry.size
                            )

                            // Move to first point
                            path.move(to: CGPoint(x: points[0].x, y: points[0].y))

                            // Draw lines to each point
                            for i in 1..<points.count {
                                path.addLine(to: CGPoint(x: points[i].x, y: points[i].y))
                            }

                            // Complete the path to the bottom right & left
                            path.addLine(to: CGPoint(x: points[points.count - 1].x, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: points[0].x, y: geometry.size.height))
                            path.closeSubpath()
                        }
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green.opacity(0.4), Color.green.opacity(0.01)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )

                        // Line
                        Path { path in
                            let points = calculatePoints(
                                data: filteredData,
                                size: geometry.size
                            )

                            // Move to first point
                            path.move(to: CGPoint(x: points[0].x, y: points[0].y))

                            // Draw lines to each point
                            for i in 1..<points.count {
                                path.addLine(to: CGPoint(x: points[i].x, y: points[i].y))
                            }
                        }
                        .stroke(Color.green, lineWidth: 2)
                    }
                }
            }
            .frame(height: 150)

            // X-axis labels
            HStack {
                ForEach(xAxisLabels, id: \.self) { label in
                    Text(label)
                        .font(.system(size: 9))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }

    // Calculate points for line chart
    private func calculatePoints(data: [InvestmentData], size: CGSize) -> [(x: CGFloat, y: CGFloat)] {
        guard !data.isEmpty, let minValue = data.map({ $0.value }).min(), let maxValue = data.map({ $0.value }).max() else {
            return []
        }

        let valueDiff = maxValue - minValue
        var points: [(x: CGFloat, y: CGFloat)] = []

        // Calculate x and y coordinates for each data point
        for (index, datum) in data.enumerated() {
            let x = size.width * (CGFloat(index) / CGFloat(data.count - 1))

            // Normalize value between 0 and 1, then invert for y coordinate (0 is top in UI)
            let normalizedValue = valueDiff > 0 ? CGFloat((datum.value - minValue) / valueDiff) : 0
            let y = size.height * (1 - normalizedValue)

            points.append((x: x, y: y))
        }

        return points
    }

    // Current value (latest investment value)
    private var currentValue: Double {
        investmentData.last?.value ?? 0
    }

    // Calculate percentage change from filtered data
    private var percentageChange: Double {
        guard let firstValue = filteredData.first?.value,
              let lastValue = filteredData.last?.value,
              firstValue > 0 else {
            return 0
        }

        return ((lastValue - firstValue) / firstValue) * 100
    }

    // Filter data based on selected period
    private var filteredData: [InvestmentData] {
        guard let latestDate = investmentData.last?.date else {
            return []
        }

        let calendar = Calendar.current
        let filteredData: [InvestmentData]

        switch period {
        case .week:
            // Last 7 days
            let weekAgo = calendar.date(byAdding: .day, value: -7, to: latestDate) ?? latestDate
            filteredData = investmentData.filter { $0.date >= weekAgo }
        case .month:
            // Last 30 days
            let monthAgo = calendar.date(byAdding: .day, value: -30, to: latestDate) ?? latestDate
            filteredData = investmentData.filter { $0.date >= monthAgo }
        case .quarter:
            // Last 90 days
            let quarterAgo = calendar.date(byAdding: .day, value: -90, to: latestDate) ?? latestDate
            filteredData = investmentData.filter { $0.date >= quarterAgo }
        case .year:
            // Last 365 days
            let yearAgo = calendar.date(byAdding: .day, value: -365, to: latestDate) ?? latestDate
            filteredData = investmentData.filter { $0.date >= yearAgo }
        case .all:
            filteredData = investmentData
        }

        // For simplified display, take every nth element based on the number of data points
        let strideStep = max(1, filteredData.count / 20)
        return stride(from: 0, to: filteredData.count, by: strideStep).map { filteredData[$0] }
    }

    // X-axis labels
    private var xAxisLabels: [String] {
        let dateFormatter = DateFormatter()

        switch period {
        case .week:
            dateFormatter.dateFormat = "EEE"
        case .month:
            dateFormatter.dateFormat = "d MMM"
        case .quarter, .year:
            dateFormatter.dateFormat = "MMM"
        case .all:
            dateFormatter.dateFormat = "MMM yy"
        }

        // Generate evenly-spaced labels
        let count = 5  // Number of labels
        return stride(from: 0, to: filteredData.count, by: max(1, filteredData.count / count)).map { index in
            if index < filteredData.count {
                return dateFormatter.string(from: filteredData[index].date)
            } else {
                return ""
            }
        }
    }
}
