//
//  MockBankingService.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//
//
//import Foundation
//
//class MockBankingService: BankingService {
//    func getAccounts() async throws -> [BankAccount] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        return [
//            BankAccount(
//                id: "acc_001",
//                name: "Primary Checking",
//                type: .checking,
//                balance: 4567.89,
//                currency: .usd,
//                accountNumber: "****4321",
//                routingNumber: "021000021",
//                isDefault: true
//            ),
//            BankAccount(
//                id: "acc_002",
//                name: "High-Yield Savings",
//                type: .savings,
//                balance: 15320.45,
//                currency: .usd,
//                accountNumber: "****5678",
//                routingNumber: "021000021",
//                isDefault: false
//            ),
//            BankAccount(
//                id: "acc_003",
//                name: "Investment Account",
//                type: .investment,
//                balance: 47890.32,
//                currency: .usd,
//                accountNumber: "****9012",
//                routingNumber: nil,
//                isDefault: false
//            )
//        ]
//    }
//
//    func getTransactions(for account: BankAccount, from: Date, to: Date) async throws -> [Transaction] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        // Generate mock transactions for the given date range
//        let transactions = generateMockTransactions(for: account, from: from, to: to)
//        return transactions
//    }
//
//    func getCards() async throws -> [Card] {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        return [
//            Card(
//                id: "card_001",
//                type: .debit,
//                lastFour: "4321",
//                expiryMonth: 12,
//                expiryYear: 2028,
//                cardholderName: "JOHN DOE",
//                isActive: true,
//                dailyLimit: 5000,
//                monthlyLimit: 25000
//            ),
//            Card(
//                id: "card_002",
//                type: .credit,
//                lastFour: "5678",
//                expiryMonth: 3,
//                expiryYear: 2027,
//                cardholderName: "JOHN DOE",
//                isActive: true,
//                dailyLimit: nil,
//                monthlyLimit: nil
//            )
//        ]
//    }
//
//    func getTransactionDetails(id: String) async throws -> TransactionDetail {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        // Find the mock transaction
//        let transactions = generateMockTransactions(
//            for: BankAccount(
//                id: "acc_001",
//                name: "Primary Checking",
//                type: .checking,
//                balance: 4567.89,
//                currency: .usd,
//                accountNumber: "****4321",
//                routingNumber: "021000021",
//                isDefault: true
//            ),
//            from: Date().addingTimeInterval(-30 * 24 * 60 * 60),
//            to: Date()
//        )
//
//        guard let transaction = transactions.first(where: { $0.id == id }) else {
//            throw ServiceError.notFound
//        }
//
//        return TransactionDetail(
//            id: transaction.id,
//            transaction: transaction,
//            location: TransactionDetail.Location(
//                latitude: 37.7749,
//                longitude: -122.4194,
//                address: "123 Market St",
//                city: "San Francisco",
//                state: "CA",
//                country: "USA"
//            ),
//            notes: "Business lunch with clients",
//            attachments: [
//                TransactionDetail.Attachment(
//                    id: "att_001",
//                    url: URL(string: "https://example.com/receipts/receipt_001.pdf")!,
//                    type: .receipt,
//                    name: "Receipt_001.pdf"
//                )
//            ],
//            tags: ["Business", "Tax Deductible"]
//        )
//    }
//
//    func transferMoney(from: BankAccount, to: BankAccount, amount: Double, note: String?) async throws -> Transaction {
//        // Simulate network delay
//        try await Task.sleep(nanoseconds: 1_000_000_000)
//
//        // Check if amount is valid
//        guard amount > 0 else {
//            throw ServiceError.invalidAmount
//        }
//
//        // Check if source account has sufficient funds
//        guard from.balance >= amount else {
//            throw ServiceError.insufficientFunds
//        }
//
//        // Create a new transaction
//        let transaction = Transaction(
//            id: "txn_\(UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(10))",
//            date: Date(),
//            amount: -amount,
//            description: "Transfer to \(to.name)",
//            category: .transfer,
//            merchant: nil,
//            type: .transfer,
//            status: .completed,
//            accountId: from.id
//        )
//
//        return transaction
//    }
//
//        // Helper method to generate mock transactions
//        private func generateMockTransactions(for account: BankAccount, from: Date, to: Date) -> [Transaction] {
//            let merchants: [Merchant] = [
//                Merchant(id: "merch_001", name: "Starbucks", category: .food, logoUrl: URL(string: "https://example.com/logos/starbucks.png")),
//                Merchant(id: "merch_002", name: "Amazon", category: .shopping, logoUrl: URL(string: "https://example.com/logos/amazon.png")),
//                Merchant(id: "merch_003", name: "Uber", category: .transportation, logoUrl: URL(string: "https://example.com/logos/uber.png")),
//                Merchant(id: "merch_004", name: "Target", category: .shopping, logoUrl: URL(string: "https://example.com/logos/target.png")),
//                Merchant(id: "merch_005", name: "Netflix", category: .entertainment, logoUrl: URL(string: "https://example.com/logos/netflix.png"))
//            ]
//
//            let calendar = Calendar.current
//            let daysBetween = calendar.dateComponents([.day], from: from, to: to).day ?? 0
//
//            var transactions: [Transaction] = []
//
//            // Generate random transactions for each day
//            for day in 0...daysBetween {
//                if let date = calendar.date(byAdding: .day, value: day, to: from) {
//                    // Generate 1-3 transactions per day
//                    let transactionsPerDay = Int.random(in: 1...3)
//
//                    for _ in 0..<transactionsPerDay {
//                        // Randomize transaction details
//                        let merchantIndex = Int.random(in: 0..<merchants.count)
//                        let merchant = merchants[merchantIndex]
//
//                        let isCredit = Double.random(in: 0...1) < 0.2  // 20% chance of being a credit transaction
//                        let amount = isCredit ?
//                                     Double.random(in: 50...300) :
//                                     -Double.random(in: 5...150)
//
//                        let type: Transaction.TransactionType = isCredit ? .credit : .debit
//
//                        let transaction = Transaction(
//                            id: "txn_\(UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(10))",
//                            date: date,
//                            amount: amount,
//                            description: isCredit ? "Deposit" : "Purchase at \(merchant.name)",
//                            category: merchant.category,
//                            merchant: merchant,
//                            type: type,
//                            status: .completed,
//                            accountId: account.id
//                        )
//
//                        transactions.append(transaction)
//                    }
//                }
//            }
//
//            return transactions.sorted { $0.date > $1.date }  // Sort by date, newest first
//        }
//    }
//
//    enum ServiceError: Error {
//        case notFound
//        case invalidAmount
//        case insufficientFunds
//        case unauthorized
//        case networkError
//        case serverError
//        case unknown
//    }
