//
//  HomeViewModel.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: -BACK-END 

//import Foundation
//import Combine
//
//class HomeViewModel: ObservableObject {
//    // Published properties
//    @Published var accounts: [BankAccount] = []
//    @Published var cards: [Card] = []
//    @Published var recentTransactions: [Transaction] = []
//    @Published var isLoading = false
//    @Published var error: Error?
//
//    // Services
//    private let bankingService: BankingService
//
//    // Cancellables
//    private var cancellables = Set<AnyCancellable>()
//
//    init(bankingService: BankingService = ServiceFactory.shared.bankingService()) {
//        self.bankingService = bankingService
//    }
//
//    func loadData() {
//        isLoading = true
//        error = nil
//
//        // Create a task group for parallel fetching
//        Task {
//            do {
//                // Fetch accounts and cards in parallel
//                async let accountsTask = bankingService.getAccounts()
//                async let cardsTask = bankingService.getCards()
//
//                // Wait for results
//                let fetchedAccounts = try await accountsTask
//                let fetchedCards = try await cardsTask
//
//                // Fetch recent transactions for the default account
//                let defaultAccount = fetchedAccounts.first(where: { $0.isDefault }) ?? fetchedAccounts.first
//
//                if let account = defaultAccount {
//                    let calendar = Calendar.current
//                    let endDate = Date()
//                    let startDate = calendar.date(byAdding: .day, value: -30, to: endDate)!
//
//                    let transactions = try await bankingService.getTransactions(
//                        for: account,
//                        from: startDate,
//                        to: endDate
//                    )
//
//                    // Update UI on main thread
//                    await MainActor.run {
//                        self.accounts = fetchedAccounts
//                        self.cards = fetchedCards
//                        self.recentTransactions = Array(transactions.prefix(10))  // Show only 10 most recent
//                        self.isLoading = false
//                    }
//                } else {
//                    await MainActor.run {
//                        self.accounts = fetchedAccounts
//                        self.cards = fetchedCards
//                        self.isLoading = false
//                    }
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
//        loadData()
//    }
//}
