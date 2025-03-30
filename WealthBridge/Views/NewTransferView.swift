//
//  NewTransferView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-03-19.
//

// Views/NewTransferView.swift
import SwiftUI

struct NewTransferView: View {
    // MARK: - Properties
    @Binding var isPresented: Bool
    @State private var selectedOption: TransferOption = .send
    @State private var searchText = ""
    @State private var selectedContact: Contact? = nil
    @State private var amount = ""
    @State private var note = ""

    // Sample contacts
    private let contacts = [
            Contact(id: 1, name: "Carlito K", image: "person1"),
            Contact(id: 2, name: "Alice V", image: "person2"),
            Contact(id: 3, name: "Victoria T", image: "person3"),
            Contact(id: 4, name: "Emma T", image: "person4"),
            Contact(id: 5, name: "Sam T", image: "person5"),
            Contact(id: 6, name: "Joe T", image: "person6"),
            Contact(id: 7, name: "Gideon T", image: "person7"),
            Contact(id: 8, name: "Oliver T", image: "person8"),
            Contact(id: 15, name: "David K", image: "person10"),
            Contact(id: 9, name: "Diane N", image: "person11"),
            Contact(id: 10, name: "Noela N", image: "person12"),
            Contact(id: 11, name: "James N", image: "person13"),
            Contact(id: 12, name: "Bene K", image: "person14"),
            Contact(id: 13, name: "Grace", image: "person15"),
            Contact(id: 14, name: "Dora", image: "person16")
        ]

    enum TransferOption {
        case send
        case request
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                // Transfer type selector
                Picker("Transfer Type", selection: $selectedOption) {
                    Text("Send Money").tag(TransferOption.send)
                    Text("Request Money").tag(TransferOption.request)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Search and contact selection
                VStack(alignment: .leading, spacing: 10) {
                    Text("To:")
                        .font(.headline)
                        .foregroundColor(.gray)

                    if let selectedContact = selectedContact {
                        // Show selected contact
                        contactRow(contact: selectedContact, isSelected: true)
                    } else {
                        // Show search field
                        searchField

                        // Show contact list
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(filteredContacts) { contact in
                                    contactRow(contact: contact, isSelected: false)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color("CardBackground"))
                .cornerRadius(12)

                // Amount and note
                if selectedContact != nil {
                    VStack(alignment: .leading, spacing: 15) {
                        // Amount field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Amount")
                                .font(.headline)
                                .foregroundColor(.gray)

                            HStack {
                                Text("$")
                                    .foregroundColor(.gray)
                                TextField("0.00", text: $amount)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(Color("CardBackground"))
                            .cornerRadius(8)
                        }

                        // Note field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Note")
                                .font(.headline)
                                .foregroundColor(.gray)

                            TextField("What's it for?", text: $note)
                                .padding()
                                .background(Color("CardBackground"))
                                .cornerRadius(8)
                        }
                    }

                    // Send/Request button
                    Button(action: {
                        // Handle transfer
                        isPresented = false
                    }) {
                        Text(selectedOption == .send ? "Send Money" : "Request Money")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(amount.isEmpty ? Color.gray : (selectedOption == .send ? Color.blue : Color.green))
                            .cornerRadius(12)
                    }
                    .disabled(amount.isEmpty)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top)
            .navigationTitle(selectedOption == .send ? "Send Money" : "Request Money")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }

    // MARK: - Subviews
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search contacts", text: $searchText)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }

    private func contactRow(contact: Contact, isSelected: Bool) -> some View {
        Button(action: {
            if isSelected {
                // Deselect contact
                selectedContact = nil
            } else {
                // Select contact
                selectedContact = contact
            }
        }) {
            HStack {
                Image(contact.image) // will use a placeholder or system icon if needed
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())

                Text(contact.name)
                    .foregroundColor(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
    }


    //Computed Properties
    private var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
