//
//  MockInvestmentService.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: - BACK-END
//
//import Foundation
//
//class MockInvestmentService: InvestmentService {
//    func getPortfolio() async throws -> Portfolio {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        let investments = try await getInvestments()
//
//        let totalValue = investments.reduce(0) { $0 + $1.value } + 5000.0  // Cash value
//        let dayChange = investments.reduce(0) { $0 + $1.dayChange }
//        let dayChangePercentage = (dayChange / totalValue) * 100
//
//        let totalGain = investments.reduce(0) { $0 + $1.totalGain }
//        let totalGainPercentage = (totalGain / totalValue) * 100
//
//        return Portfolio(
//            id: "port_001",
//            totalValue: totalValue,
//            dayChange: dayChange,
//            dayChangePercentage: dayChangePercentage,
//            totalGain: totalGain,
//            totalGainPercentage: totalGainPercentage,
//            holdings: investments,
//            cash: 5000.0
//        )
//    }
//
//    func getInvestments() async throws -> [Investment] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        return [
//            Investment(
//                id: "inv_001",
//                symbol: "AAPL",
//                name: "Apple Inc.",
//                type: .stock,
//                shares: 10,
//                averageCost: 145.75,
//                currentPrice: 175.50,
//                value: 1755.0,
//                dayChange: 25.0,
//                dayChangePercentage: 1.45,
//                totalGain: 297.5,
//                totalGainPercentage: 20.41
//            ),
//            Investment(
//                id: "inv_002",
//                symbol: "MSFT",
//                name: "Microsoft Corporation",
//                type: .stock,
//                shares: 5,
//                averageCost: 220.50,
//                currentPrice: 290.75,
//                value: 1453.75,
//                dayChange: 15.5,
//                dayChangePercentage: 1.08,
//                totalGain: 351.25,
//                totalGainPercentage: 31.86
//            ),
//            Investment(
//                id: "inv_003",
//                symbol: "VTI",
//                name: "Vanguard Total Stock Market ETF",
//                type: .etf,
//                shares: 15,
//                averageCost: 190.25,
//                currentPrice: 215.80,
//                value: 3237.0,
//                dayChange: 22.5,
//                dayChangePercentage: 0.70,
//                totalGain: 383.25,
//                totalGainPercentage: 13.43
//            ),
//            Investment(
//                id: "inv_004",
//                symbol: "BTC",
//                name: "Bitcoin",
//                type: .crypto,
//                shares: 0.25,
//                averageCost: 37500.0,
//                currentPrice: 50000.0,
//                value: 12500.0,
//                dayChange: 750.0,
//                dayChangePercentage: 6.38,
//                totalGain: 3125.0,
//                totalGainPercentage: 33.33
//            )
//        ]
//    }
//
//    func getInvestmentHistory(for investment: Investment, period: TimePeriod) async throws -> [InvestmentDataPoint] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        let calendar = Calendar.current
//        let today = Date()
//        let dataPoints: [InvestmentDataPoint]
//
//        switch period {
//        case .week:
//            // Generate daily data for the past 7 days
//            dataPoints = (0...6).reversed().compactMap { day in
//                if let date = calendar.date(byAdding: .day, value: -day, to: today) {
//                    return createDataPoint(for: investment, on: date, volatility: 0.02)
//                }
//                return nil
//            }
//        case .month:
//            // Generate daily data for the past 30 days
//            dataPoints = (0...29).reversed().compactMap { day in
//                if let date = calendar.date(byAdding: .day, value: -day, to: today) {
//                    return createDataPoint(for: investment, on: date, volatility: 0.03)
//                }
//                return nil
//            }
//        case .quarter:
//            // Generate weekly data for the past 90 days
//            dataPoints = (0...12).reversed().compactMap { week in
//                if let date = calendar.date(byAdding: .weekOfYear, value: -week, to: today) {
//                    return createDataPoint(for: investment, on: date, volatility: 0.05)
//                }
//                return nil
//            }
//        case .year:
//            // Generate monthly data for the past year
//            dataPoints = (0...11).reversed().compactMap { month in
//                if let date = calendar.date(byAdding: .month, value: -month, to: today) {
//                    return createDataPoint(for: investment, on: date, volatility: 0.08)
//                }
//                return nil
//            }
//        case .all:
//            // Generate yearly data for the past 5 years
//            dataPoints = (0...4).reversed().compactMap { year in
//                if let date = calendar.date(byAdding: .year, value: -year, to: today) {
//                    return createDataPoint(for: investment, on: date, volatility: 0.15)
//                }
//                return nil
//            }
//        }
//
//        return dataPoints
//    }
//
//    func getMarketData(symbols: [String]) async throws -> [MarketData] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        let stockData: [String: (name: String, price: Double, change: Double, marketCap: Double)] = [
//            "AAPL": ("Apple Inc.", 175.50, 2.35, 2850000000000),
//            "MSFT": ("Microsoft Corporation", 290.75, 1.25, 2200000000000),
//            "AMZN": ("Amazon.com Inc.", 3200.50, -12.75, 1620000000000),
//            "GOOGL": ("Alphabet Inc.", 2450.20, 15.30, 1580000000000),
//            "META": ("Meta Platforms Inc.", 330.25, 5.75, 880000000000),
//            "TSLA": ("Tesla Inc.", 950.50, 23.80, 960000000000),
//            "NVDA": ("NVIDIA Corporation", 580.75, 8.25, 725000000000)
//        ]
//
//        var marketDataList: [MarketData] = []
//
//        for symbol in symbols {
//            if let data = stockData[symbol] {
//                let changePercentage = (data.change / data.price) * 100
//
//                let marketData = MarketData(
//                    id: "mkt_\(symbol)",
//                    symbol: symbol,
//                    name: data.name,
//                    price: data.price,
//                    change: data.change,
//                    changePercentage: changePercentage,
//                    marketCap: data.marketCap,
//                    volume: Int.random(in: 1000000...50000000),
//                    high52Week: data.price * 1.2,
//                    low52Week: data.price * 0.8
//                )
//
//                marketDataList.append(marketData)
//            }
//        }
//
//        return marketDataList
//    }
//
//    func executeOrder(order: InvestmentOrder) async throws -> OrderConfirmation {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 2_000_000_000)
//
//        // Mock successful order
//        let estimatedTotal: Double
//
//        if order.action == .buy {
//            // Get the price from market data
//            let marketData = try await getMarketData(symbols: [order.symbol])
//            guard let stockData = marketData.first else {
//                throw ServiceError.notFound
//            }
//
//            // Calculate total
//            estimatedTotal = stockData.price * order.quantity
//        } else {
//            // Selling - calculate based on current holdings
//            let investments = try await getInvestments()
//            guard let investment = investments.first(where: { $0.symbol == order.symbol }) else {
//                throw ServiceError.notFound
//            }
//
//            // Check if user has enough shares
//            guard investment.shares >= order.quantity else {
//                throw ServiceError.insufficientFunds
//            }
//
//            // Calculate total
//            estimatedTotal = investment.currentPrice * order.quantity
//        }
//
//        return OrderConfirmation(
//            id: "ord_\(UUID().uuidString.prefix(8))",
//            orderTime: Date(),
//            order: order,
//            status: .pending,
//            estimatedCommission: estimatedTotal * 0.0025,  // 0.25% commission
//            estimatedTotal: estimatedTotal
//        )
//    }
//
//    // Helper function to create a data point with randomized price
//    private func createDataPoint(for investment: Investment, on date: Date, volatility: Double) -> InvestmentDataPoint {
//        // Randomize price based on volatility
//        let randomChange = investment.currentPrice * Double.random(in: -volatility...volatility)
//        let price = max(0, investment.currentPrice + randomChange)
//
//        return InvestmentDataPoint(
//            date: date,
//            price: price,
//            volume: Int.random(in: 100000...10000000)
//        )
//    }
//}
