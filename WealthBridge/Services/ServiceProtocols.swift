//
//  ServiceProtocols.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

//MARK: - Back End code use

//import Foundation
//import Combine
//
//// Base protocol for all services
//protocol Service {
//    // Common service methods could go here
//}
//
//// Protocol for handling authentication
//protocol AuthenticationService: Service {
//    var currentUser: User? { get }
//    var isAuthenticated: Bool { get }
//
//    func signIn(email: String, password: String) async throws -> User
//    func signUp(userData: UserRegistrationData) async throws -> User
//    func signOut() async throws
//    func resetPassword(email: String) async throws
//    func verifyCode(email: String, code: String) async throws -> Bool
//}
//
//// Protocol for handling banking data
//protocol BankingService: Service {
//    func getAccounts() async throws -> [BankAccount]
//    func getTransactions(for account: BankAccount, from: Date, to: Date) async throws -> [Transaction]
//    func getCards() async throws -> [Card]
//    func getTransactionDetails(id: String) async throws -> TransactionDetail
//    func transferMoney(from: BankAccount, to: BankAccount, amount: Double, note: String?) async throws -> Transaction
//}
//
//// Protocol for handling investment data
//protocol InvestmentService: Service {
//    func getPortfolio() async throws -> Portfolio
//    func getInvestments() async throws -> [Investment]
//    func getInvestmentHistory(for investment: Investment, period: TimePeriod) async throws -> [InvestmentDataPoint]
//    func getMarketData(symbols: [String]) async throws -> [MarketData]
//    func executeOrder(order: InvestmentOrder) async throws -> OrderConfirmation
//}
//
//// Protocol for handling user profile and settings
//protocol UserProfileService: Service {
//    func getUserProfile() async throws -> UserProfile
//    func updateUserProfile(profile: UserProfile) async throws -> UserProfile
//    func updateSettings(settings: AppSettings) async throws -> AppSettings
//    func getSettings() async throws -> AppSettings
//}
//
//// Protocol for analytics data
//protocol AnalyticsService: Service {
//    func getSpendingAnalytics(period: TimePeriod) async throws -> SpendingAnalytics
//    func getIncomeAnalytics(period: TimePeriod) async throws -> IncomeAnalytics
//    func getInvestmentAnalytics(period: TimePeriod) async throws -> InvestmentAnalytics
//    func getBudgetProgress() async throws -> BudgetProgress
//}
//
//// Protocol for cashback and offers
//protocol OffersService: Service {
//    func getAvailableOffers() async throws -> [CashbackOffer]
//    func getSubscriptionPlans() async throws -> [SubscriptionPlan]
//    func activateOffer(offerId: String) async throws -> ActivationResult
//    func upgradeSubscription(plan: SubscriptionPlan) async throws -> SubscriptionConfirmation
//}
