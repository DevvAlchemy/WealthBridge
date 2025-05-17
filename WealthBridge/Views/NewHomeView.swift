//
//  NewHomeView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// Views/HomeView.swift (Updated to use HomeViewModel)
//
//import SwiftUI
//
//struct HomeView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    @State private var selectedCard = 0
//    @State private var showNotification = false
//    @State private var showTransferView = false
//    @State private var selectedContact: Contact?
//
//    // Sample contacts data
//    @State private var recentContacts: [Contact] = [
//        Contact(id: 1, name: "John", image: "person1"),
//        Contact(id: 2, name: "Sarah", image: "person2"),
//        Contact(id: 3, name: "Mike", image: "person3"),
//        Contact(id: 4, name: "Emma", image: "person4"),
//        Contact(id: 5, name: "David", image: "person5")
//    ]
//
//    var body: some View {
//        // Existing HomeView content...
//
//        // Using data from view model
//        VStack(spacing: 20) {
//            headerView
//
//            if viewModel.isLoading {
//                ProgressView()
//                    .padding()
//            } else if let error = viewModel.error {
//                ErrorView(error: error, retryAction: viewModel.refreshData)
//            } else {
//                ScrollView {
//                    VStack(spacing: 25) {
//                        // Card carousel using viewModel.cards
//                        cardsSection
//
//                        // Send/Request section
//                        sendRequestSection
//
//                        // Latest Activity using viewModel.recentTransactions
//                        activitySection
//                    }
//                    .padding(.horizontal)
//                }
//                .refreshable {
//                    viewModel.refreshData()
//                }
//            }
//        }
//        .onAppear {
//            viewModel.loadData()
//        }
//    }
//
//    private var cardsSection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            HStack {
//                Text("My Cards")
//                    .font(.title2)
//                    .fontWeight(.bold)
//
//                Image(systemName: "chevron.down")
//                    .foregroundColor(.gray)
//            }
//
//            if viewModel.cards.isEmpty {
//                Text("No cards available")
//                    .foregroundColor(.gray)
//                    .padding()
//            } else {
//                TabView(selection: $selectedCard) {
//                    ForEach(viewModel.cards.indices, id: \.self) { index in
//                        CardView(card: viewModel.cards[index])
//                            .padding(.horizontal, 5)
//                    }
//                }
//                .frame(height: 220)
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            }
//        }
//    }
//
//    private var activitySection: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            HStack {
//                Text("Latest Activity")
//                    .font(.title2)
//                    .fontWeight(.bold)
//
//                Spacer()
//
//                Button("See all") {
//                    // Navigate to full transaction history
//                }
//                .foregroundColor(.green)
//            }
//
//            if viewModel.recentTransactions.isEmpty {
//                Text("No recent transactions")
//                    .foregroundColor(.gray)
//                    .padding()
//            } else {
//                VStack(spacing: 12) {
//                    ForEach(viewModel.recentTransactions) { transaction in
//                        TransactionRow(transaction: transaction)
//                    }
//                }
//            }
//        }
//    }
//
//    // Existing headerView and sendRequestSection implementations...
//}
//
//// Error View
//struct ErrorView: View {
//    let error: Error
//    let retryAction: () -> Void
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Image(systemName: "exclamationmark.triangle")
//                .font(.system(size: 50))
//                .foregroundColor(.red)
//
//            Text("Error")
//                .font(.title)
//                .fontWeight(.bold)
//
//            Text(error.localizedDescription)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
//
//            Button(action: retryAction) {
//                Text("Retry")
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 24)
//                    .padding(.vertical, 12)
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//    }
//}
