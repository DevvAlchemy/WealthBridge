//
//  HomeView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-15.
//

// HomeView.swift
import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State private var selectedCard = 0
    @State private var showNotification = false

    // Sample data - In a real app, this would come from a data service
    @State private var cards: [Card] = [
        Card(type: "Business",
             balance: 487_775.87, //figure spacing solution next time i read this
             cardNumber: "**** **** **** 6598",
             holderName: "Stacy Kalala",
             expiryDate: "03/2030",
             color: .purple
            )
    ]

    @State private var watchlist: [WatchlistItem] = [
        WatchlistItem(symbol: "AAPL", name: "Apple Inc.", price: 178.72, percentageChange: 2.45, type: .stock),
        WatchlistItem(symbol: "BTC", name: "Bitcoin", price: 51_240.30, percentageChange: -1.20, type: .crypto),
        WatchlistItem(symbol: "TSLA", name: "Tesla", price: 209.45, percentageChange: 3.75, type: .stock)
    ]

    @State private var recentContacts: [Contact] = [
        Contact(id: 1, name: "John", image: "person1"),
        Contact(id: 2, name: "Sarah", image: "person2"),
        Contact(id: 3, name: "Mike", image: "person3"),
        Contact(id: 4, name: "Eliyanah", image: "person4"),
        Contact(id: 5, name: "Huey", image: "person5")
    ]

    @State private var recentTransactions: [Transaction] = [
        Transaction(id: 1, title: "Phone Bill", date: "Jan 25th", amount: -51.75, type: .debit),
        Transaction(id: 2, title: "Amazon Refund", date: "Jan 23rd", amount: 124.99, type: .credit),
        Transaction(id: 3, title: "Entertainment", date: "Jan 23rd", amount: -24.99, type: .debit),
        Transaction(id: 4, title: "Wifi Bill", date: "Jan 15th", amount: -79.95, type: .debit),
        Transaction(id: 5, title: "Regal Tech Pay", date: "Jan 5th", amount: 5750.00, type: .credit)
    ]


    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    headerView

                    //views section  begin here
                    ScrollView {
                        VStack(spacing: 25) {
                            cardsSection
                            watchlistSection
                            sendRequestSection(contacts: recentContacts) //passed array as parimeter here because Swiftui won't allow to pass @states within same view
                            activitySection(transactions: recentTransactions)//passed array as parimeter here because Swiftui won't allow to pass @states within same view
                            // Future sections will go here
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }


    private var headerView: some View {
        HStack {
            HStack {
                Image("profile-placeholder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello,")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Stacy")
                        .font(.title2)
                        .fontWeight(.bold)
                        .ignoresSafeArea(.all) // Add safe area to all space later. 
                }
            }

            Spacer()

            Button(action: {
                showNotification.toggle()
            }) {
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 0, y: -5),
                        alignment: .topTrailing
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

    //Card section view
    private var cardsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("My Cards")
                    .font(.title2)
                    .fontWeight(.bold)

                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
            }

            TabView(selection: $selectedCard) {
                ForEach(cards.indices, id: \.self) { index in
                    CardView(card: cards[index])
                        .padding(.horizontal, 5)
                }
            }
            .frame(height: 220)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }

    //Watchlist section view on screen
    private var watchlistSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Watchlist")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Button("See All") {
                    // Navigate to full watchlist
                }
                .foregroundColor(.green)
            }

            ForEach(watchlist) { item in
                WatchlistItemRow(item: item)
            }
        }
    }
}

//Send or Request Transfer section
private func sendRequestSection(contacts: [Contact]) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text("Send / Request Money")
            .font(.title2)
            .fontWeight(.bold)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing:15) {
                Button(action: { /*Will  add contact action when i fix design */ }) {
                    VStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            )

                        Text("Add")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                ForEach(contacts) { contact in
                    ContactCircle(contact: contact) {
                        // Handle contact selection action
                    }
                }
            }
            .padding(.horizontal, 5)
        }
    }
}

private func activitySection(transactions: [Transaction]) -> some View {
    VStack(alignment: .leading, spacing: 5) {
        HStack {
            Text("Latest Activity")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            Button("See all") {
                // Navigates to full transaction history
            }
            .foregroundColor(.green)
        }

        VStack(spacing: 12) {
            ForEach(transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
