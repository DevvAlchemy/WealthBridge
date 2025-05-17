//
//  DefaultView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

import SwiftUICore
import SwiftUI

// Additional placeholders for the remaining settings views file
// _____________________________________________________ //
//
//struct DefaultAccountView: View {
//    @State private var selectedAccount = 0
//
//    var body: some View {
//        List {
//            ForEach(0..<3) { index in
//                Button(action: {
//                    selectedAccount = index
//                }) {
//                    HStack {
//                        accountTypeIcon(index)
//                            .foregroundColor(.blue)
//                            .frame(width: 40, height: 40)
//                            .background(Color.blue.opacity(0.1))
//                            .clipShape(Circle())
//
//                        VStack(alignment: .leading) {
//                            Text(accountName(index))
//                                .font(.headline)
//                            Text(accountNumber(index))
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//
//                        Spacer()
//
//                        if selectedAccount == index {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.blue)
//                        }
//                    }
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//        }
//        .navigationTitle("Default Account")
//    }
//
//    private func accountTypeIcon(_ index: Int) -> Image {
//        let icons = ["dollarsign.circle.fill", "creditcard.fill", "banknote.fill"]
//        return Image(systemName: icons[index % icons.count])
//    }
//
//    private func accountName(_ index: Int) -> String {
//        let names = ["Primary Checking", "Visa Platinum", "Savings Account"]
//        return names[index % names.count]
//    }
//
//    private func accountNumber(_ index: Int) -> String {
//        let numbers = ["••••4567", "••••8901", "••••3456"]
//        return numbers[index % numbers.count]
//    }
//}
//
//struct ReportProblemView: View {
//    @State private var problemCategory = 0
//    @State private var problemDescription = ""
//    @State private var includeScreenshot = true
//    @State private var includeDeviceInfo = true
//    @State private var showThankYou = false
//
//    let categories = ["App Crash", "Payment Issue", "Account Problem", "Feature Request", "Other"]
//
//    var body: some View {
//        Form {
//            Section(header: Text("Problem Details")) {
//                Picker("Category", selection: $problemCategory) {
//                    ForEach(0..<categories.count) { index in
//                        Text(categories[index]).tag(index)
//                    }
//                }
//
//                ZStack(alignment: .topLeading) {
//                    if problemDescription.isEmpty {
//                        Text("Describe the issue in detail...")
//                            .foregroundColor(.gray)
//                            .padding(.top, 8)
//                            .padding(.leading, 5)
//                    }
//
//                    TextEditor(text: $problemDescription)
//                        .frame(minHeight: 150)
//                }
//            }
//
//            Section(header: Text("Additional Information")) {
//                Toggle("Include Screenshot", isOn: $includeScreenshot)
//                Toggle("Include Device Information", isOn: $includeDeviceInfo)
//            }
//
//            Section {
//                Button("Submit Report") {
//                    showThankYou = true
//                }
//                .frame(maxWidth: .infinity)
//                .foregroundColor(.white)
//                .padding(.vertical, 8)
//                .background(Color.blue)
//                .cornerRadius(8)
//            }
//        }
//        .navigationTitle("Report a Problem")
//        .alert(isPresented: $showThankYou) {
//            Alert(
//                title: Text("Thank You"),
//                message: Text("Your report has been submitted. Our team will investigate the issue."),
//                dismissButton: .default(Text("OK"))
//            )
//        }
//    }
//}
