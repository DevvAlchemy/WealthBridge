//
//  ServiceFactory.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// MARK: -BACK-END CODE FOR DATA

//
//import Foundation
//
//// Singleton service factory to provide access to services
//class ServiceFactory {
//    // Shared instance
//    static let shared = ServiceFactory()
//
//    // Service instances
//    private lazy var networkService = NetworkService(baseURL: baseURL)
//    private lazy var authenticationServiceInstance = AuthenticationServiceImpl(networkService: networkService)
//    private lazy var mockBankingServiceInstance = MockBankingService()
//    private lazy var mockInvestmentServiceInstance = MockInvestmentService()
//    private lazy var mockAnalyticsServiceInstance = MockAnalyticsService()
//    private lazy var mockOffersServiceInstance = MockOffersService()
//
//    // Base URL for API
//    private let baseURL = URL(string: "https://api.wealthbridge.example.com")!
//
//    // Private initializer for singleton
//    private init() {}
//
//    // MARK: - Service accessors
//
//    func authenticationService() -> AuthenticationService {
//        return authenticationServiceInstance
//    }
//
//    func bankingService() -> BankingService {
//        return mockBankingServiceInstance
//    }
//
//    func investmentService() -> InvestmentService {
//        return mockInvestmentServiceInstance
//    }
//
//    func analyticsService() -> AnalyticsService {
//        return mockAnalyticsServiceInstance
//    }
//
//    func offersService() -> OffersService {
//        return mockOffersServiceInstance
//    }
//}
