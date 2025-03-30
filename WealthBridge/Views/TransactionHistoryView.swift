//
//  TransactionHistoryView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-17.
//

/*
import SwiftUI

struct TransactionHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var sortOrder: SortOrder = .newest
    @State private var filterType: TransactionFilterType = .all

    enum SortOrder {
        case newest, oldest,highest, lowest
    }

    enum TransactionFilterType {
        case all, income, expense
    }

    let transactions: [Transaction]

    var body: some View {
        NavigationView {
            VStack {
                //filter and sorting options
                HStack {
                    Picker("Filter", selection: $filterType) {
                        Text("All").tag(TransactionFilterType.all)
                        Text("Income").tag(TransactionFilterType.income)
                        Text("Expense").tag(TransactionFilterType.expense)
                    }
                    .pickerStyle(.segmented)
                }
                .padding()

                //When selected Filters List
                ScrollView{
                    LazyVStack(spacing: 12) {
                        ForEach(filteredTransactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transaction History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Newest First") {sortOrder = .newest}
                        Button("Oldest First") {sortOrder = .oldest}
                        Button("Highest Amount") {sortOrder = .highest}
                        Button("Lowest Amount") {sortOrder = .lowest}
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }

    private var filteredTransactions: [Transaction] {
        var filtered = transactions

        //Applying Filters logic
        switch filterType {
        case .income:
            filtered = filtered.filter { $0.amount > 0}
        case .expense:
            filtered = filtered.filter { $0.amount < 0 }
        case .all:
            break
        }
*/
