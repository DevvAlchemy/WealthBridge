//
//  PortfolioViewModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: -BACK -END

//import Foundation
//import Combine
//
//class PortfolioViewModel: ObservableObject {
//    // Published properties
//    @Published var portfolio: Portfolio?
//    @Published var investmentHistory: [String: [InvestmentDataPoint]] = [:]
//    @Published var selectedTimePeriod: TimePeriod = .month
//    @Published var isLoading = false
//    @Published var error: Error?
//
//    // Services
//    private let investmentService: InvestmentService
//
//    // Cancellables
//    private var cancellables = Set<AnyCancellable>()
//
//    init(investmentService: InvestmentService = ServiceFactory.shared.investmentService()) {
//        self.investmentService = investmentService
//
//        // Update history when time period changes
//        $selectedTimePeriod
//            .dropFirst()  // Skip initial value
//            .sink { [weak self] _ in
//                self?.loadInvestmentHistory()
//            }
//            .store(in: &cancellables)
//    }
//
//    func loadPortfolio() {
//        isLoading = true
//        error = nil
//
//        Task {
//            do {
//                let portfolio = try await investmentService.getPortfolio()
//
//                await MainActor.run {
//                    self.portfolio = portfolio
//                    self.isLoading = false
//
//                    // Load history after portfolio is loaded
//                    self.loadInvestmentHistory()
//                }
//            } catch {
//                await MainActor.run {
//                    self.error = error
//                    self.isLoading = false
//                }
//            }
//        }
//    }
//
//    func loadInvestmentHistory() {
//        guard let portfolio = portfolio else { return }
//
//        isLoading = true
//
//        Task {
//            do {
//                var historyData: [String: [InvestmentDataPoint]] = [:]
//
//                // Load history for each investment
//                for investment in portfolio.holdings {
//                    let history = try await investmentService.getInvestmentHistory(
//                        for: investment,
//                        period: selectedTimePeriod
//                    )
//                    historyData[investment.symbol] = history
//                }
//
//                await MainActor.run {
//                    self.investmentHistory = historyData
//                    self.isLoading = false
//                }
//            } catch {
//                await MainActor.run {
//                    self.error = error
//                    self.isLoading = false
//                }
//            }
//        }
//    }
//
//    func refreshData() {
//        loadPortfolio()
//    }
//}
