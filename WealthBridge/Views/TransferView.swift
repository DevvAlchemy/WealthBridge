//
//  TransferView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// TransferView.swift

import SwiftUI

struct TransferView: View {
    //  Properties
    @State private var selectedTab = 0
    @State private var showNewTransferSheet = false

    // Sample transaction data - in a real app, this would come from a data service
    @State private var transfers: [Transfer] = [
        Transfer(
            id: 1,
            recipient: "Sarah Johnson",
            amount: 250.00,
            date: "Today",
            type: .sent,
            status: .completed
        ),
        Transfer(
            id: 2,
            recipient: "John Smith",
            amount: 75.50,
            date: "Yesterday",
            type: .sent,
            status: .pending
        ),
        Transfer(
            id: 3,
            recipient: "Tech Gadgets Inc.",
            amount: 199.99,
            date: "Mar 10",
            type: .sent,
            status: .completed
        ),
        Transfer(
            id: 4,
            recipient: "Alex Brown",
            amount: 120.00,
            date: "Mar 5",
            type: .requested,
            status: .failed
        ),
        Transfer(
            id: 5,
            recipient: "Coffee House",
            amount: 45.75,
            date: "Mar 3",
            type: .sent,
            status: .completed
        )
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom tab selector
                customTabSelector

                // Content based on selected tab
                TabView(selection: $selectedTab) {
                    allTransfersView
                        .tag(0)

                    sentTransfersView
                        .tag(1)

                    requestedTransfersView
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("Transfers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewTransferSheet = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .background(Color("backgroundColor").ignoresSafeArea())
            .sheet(isPresented: $showNewTransferSheet) {
                NewTransferView(isPresented: $showNewTransferSheet)
            }
        }
    }

    // Subviews
    private var customTabSelector: some View {
        HStack {
            TabButton(title: "All", isSelected: selectedTab == 0) {
                withAnimation {
                    selectedTab = 0
                }
            }

            TabButton(title: "Sent", isSelected: selectedTab == 1) {
                withAnimation {
                    selectedTab = 1
                }
            }

            TabButton(title: "Requested", isSelected: selectedTab == 2) {
                withAnimation {
                    selectedTab = 2
                }
            }
        }
        .padding()
        .background(Color("CardBackground"))
    }

    private var allTransfersView: some View {
        transferListView(transfers: transfers)
    }

    private var sentTransfersView: some View {
        transferListView(transfers: transfers.filter { $0.type == .sent })
    }

    private var requestedTransfersView: some View {
        transferListView(transfers: transfers.filter { $0.type == .requested })
    }

    private func transferListView(transfers: [Transfer]) -> some View {
        if transfers.isEmpty {
            return AnyView(
                VStack(spacing: 20) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)

                    Text("No transfers yet")
                        .font(.headline)

                    Text("Your transfers will appear here")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        } else {
            return AnyView(
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(transfers) { transfer in
                            TransferRow(transfer: transfer)
                        }
                    }
                    .padding()
                }
            )
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
