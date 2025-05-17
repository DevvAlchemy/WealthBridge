//
//  setttingsPlaceholder.swift
//  WealthBridge
//
//  
//

import SwiftUI

// MARK: - Account Settings

struct LinkedAccountsView: View {
    var body: some View {
        List {
            Section(header: Text("Bank Accounts")) {
                placeholderRow(title: "Chase Bank", detail: "••••4567")
                placeholderRow(title: "Bank of America", detail: "••••8901")
            }

            Section(header: Text("Credit Cards")) {
                placeholderRow(title: "Visa Platinum", detail: "••••3456")
                placeholderRow(title: "American Express", detail: "••••7890")
            }

            Section {
                Button(action: {}) {
                    Label("Link a New Account", systemImage: "plus")
                }
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("Linked Accounts")
    }

    private func placeholderRow(title: String, detail: String) -> some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(title.prefix(1)))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                )

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

struct AddressView: View {
    @Binding var address: UserProfile.Address
    @Environment(\.presentationMode) var presentationMode

    @State private var street: String
    @State private var city: String
    @State private var state: String
    @State private var zipCode: String
    @State private var country: String

    init(address: Binding<UserProfile.Address>) {
        self._address = address
        self._street = State(initialValue: address.wrappedValue.street)
        self._city = State(initialValue: address.wrappedValue.city)
        self._state = State(initialValue: address.wrappedValue.state)
        self._zipCode = State(initialValue: address.wrappedValue.zipCode)
        self._country = State(initialValue: address.wrappedValue.country)
    }

    var body: some View {
        Form {
            Section(header: Text("Address Information")) {
                TextField("Street", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $state)
                TextField("ZIP Code", text: $zipCode)
                    .keyboardType(.numberPad)
                TextField("Country", text: $country)
            }

            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .navigationTitle("Address")
    }

    private func saveChanges() {
        address.street = street
        address.city = city
        address.state = state
        address.zipCode = zipCode
        address.country = country

        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Security Settings

struct ChangePasswordView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false

    var body: some View {
        Form {
            Section(header: Text("Current Password")) {
                SecureField("Enter current password", text: $currentPassword)
            }

            Section(header: Text("New Password")) {
                SecureField("Enter new password", text: $newPassword)
                SecureField("Confirm new password", text: $confirmPassword)

                Text("Password must be at least 8 characters long and include a number and special character.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Section {
                Button("Update Password") {
                    showAlert = true
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .navigationTitle("Change Password")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Updated"),
                message: Text("Your password has been updated successfully."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Preferences Settings

struct LanguageView: View {
    @Binding var selectedLanguage: AppSettings.Language
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            ForEach(AppSettings.Language.allCases) { language in
                Button(action: {
                    selectedLanguage = language
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(language.rawValue)

                        Spacer()

                        if language == selectedLanguage {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle("Select Language")
    }
}

struct DefaultAccountView: View {
    var body: some View {
        List {
            Section(header: Text("Default Account for Payments")) {
                accountRow(name: "Chase Checking", number: "••••4567", isSelected: true)
                accountRow(name: "BofA Savings", number: "••••8901", isSelected: false)
                accountRow(name: "Visa Platinum", number: "••••3456", isSelected: false)
            }
        }
        .navigationTitle("Default Account")
    }

    private func accountRow(name: String, number: String, isSelected: Bool) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(number)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

// MARK: - Help & Support

struct FAQView: View {
    var body: some View {
        List {
            faqItem(
                question: "How do I add a new bank account?",
                answer: "Go to Settings > Linked Accounts and tap 'Link a New Account'. Follow the instructions to securely connect your bank."
            )

            faqItem(
                question: "Is my data secure?",
                answer: "Yes, we use bank-level encryption to protect your data. Your sensitive information is never stored on your device."
            )

            faqItem(
                question: "How do I report an issue with a transaction?",
                answer: "Go to the transaction details page and tap the 'Report Issue' button at the bottom of the screen."
            )

            faqItem(
                question: "Can I use the app internationally?",
                answer: "Yes, the app can be used internationally, but fees may apply for currency conversion and international transactions."
            )
        }
        .navigationTitle("Frequently Asked Questions")
    }

    private func faqItem(question: String, answer: String) -> some View {
        DisclosureGroup {
            Text(answer)
                .padding(.vertical, 8)
        } label: {
            Text(question)
                .font(.headline)
        }
    }
}

struct ContactSupportView: View {
    @State private var subject = ""
    @State private var message = ""
    @State private var showAlert = false

    var body: some View {
        Form {
            Section(header: Text("Contact Information")) {
                Text("Email: support@wealthbridge.com")
                Text("Phone: +1 (555) 123-4567")
                Text("Hours: 24/7")
            }

            Section(header: Text("Message")) {
                TextField("Subject", text: $subject)

                ZStack(alignment: .topLeading) {
                    if message.isEmpty {
                        Text("Describe your issue or question...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }

                    TextEditor(text: $message)
                        .frame(minHeight: 150)
                }
            }

            Section {
                Button("Send Message") {
                    showAlert = true
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .navigationTitle("Contact Support")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Message Sent"),
                message: Text("We've received your message and will respond within 24 hours."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

// MARK: - Helper for Placeholder Views

func placeholderView(title: String) -> some View {
    VStack(spacing: 20) {
        Image(systemName: "gear")
            .font(.system(size: 50))
            .foregroundColor(.gray)

        Text(title)
            .font(.title2)

        Text("This feature is coming soon.")
            .foregroundColor(.gray)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle(title)
}

// Generic placeholder views
struct ReportProblemView: View {
    var body: some View { placeholderView(title: "Report a Problem") }
}

//struct TermsView: View {
//    var body: some View { placeholder
//
//        // Continuing with SettingsPlaceholders.swift

        struct TermsView: View {
            var body: some View {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Terms and Conditions")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Last Updated: May 16, 2025")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("1. Acceptance of Terms")
                            .font(.headline)

                        Text("By accessing or using WealthBridge, you agree to be bound by these Terms and Conditions and all applicable laws and regulations. If you do not agree with any of these terms, you are prohibited from using or accessing this app.")

                        Text("2. Use License")
                            .font(.headline)

                        Text("Permission is granted to temporarily download one copy of the materials (information or software) on WealthBridge's mobile application for personal, non-commercial transitory viewing only.")

                        Text("3. Financial Information")
                            .font(.headline)

                        Text("The financial information displayed in WealthBridge is for informational purposes only and should not be considered as financial advice. Always consult with a qualified financial advisor before making investment decisions.")

                        // More placeholder terms...
                        Text("4. Privacy Policy")
                            .font(.headline)

                        Text("Your use of WealthBridge is also governed by our Privacy Policy, which is incorporated by reference into these Terms and Conditions.")

                        Text("5. Governing Law")
                            .font(.headline)

                        Text("These terms and conditions are governed by and construed in accordance with the laws of the United States and you irrevocably submit to the exclusive jurisdiction of the courts in that location.")
                    }
                    .padding()
                }
                .navigationTitle("Terms & Conditions")
            }
        }

        struct PrivacySettingsView: View {
            @State private var locationAccess = false
            @State private var dataSharing = false
            @State private var analyticsCollection = true
            @State private var personalization = true

            var body: some View {
                Form {
                    Section(header: Text("Data Access")) {
                        Toggle("Location Access", isOn: $locationAccess)
                        Toggle("Data Sharing with Partners", isOn: $dataSharing)
                        Toggle("Analytics Collection", isOn: $analyticsCollection)
                        Toggle("Personalized Suggestions", isOn: $personalization)
                    }

                    Section(header: Text("Your Data")) {
                        Button("Download My Data") {
                            // Action to download data
                        }
                        .foregroundColor(.blue)

                        Button("Delete All My Data") {
                            // Action to delete data
                        }
                        .foregroundColor(.red)
                    }

                    Section(header: Text("About")) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                        }
                    }
                }
                .navigationTitle("Privacy Settings")
            }
        }

        struct PrivacyPolicyView: View {
            var body: some View {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Privacy Policy")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Last Updated: May 16, 2025")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("At WealthBridge, we take your privacy seriously. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.")

                        Text("Information We Collect")
                            .font(.headline)

                        Text("We may collect information about you in various ways, including:")

                        Text("• Personal Data: Name, email address, phone number, date of birth, financial information, and government-issued identification.")

                        Text("• Usage Data: Information about how you use our application, including transaction history, feature usage, and time spent on different sections.")

                        // More placeholder privacy policy...
                        Text("How We Use Your Information")
                            .font(.headline)

                        Text("We use the information we collect to:")

                        Text("• Provide, maintain, and improve our services")
                        Text("• Process your transactions and manage your accounts")
                        Text("• Communicate with you about updates, security alerts, and support")
                        Text("• Personalize your experience and deliver content relevant to your interests")

                        Text("Security")
                            .font(.headline)

                        Text("We implement appropriate technical and organizational measures to protect the security of your personal information. However, please be aware that no method of transmission over the internet or electronic storage is 100% secure.")
                    }
                    .padding()
                }
                .navigationTitle("Privacy Policy")
            }
        }

        struct LegalInformationView: View {
            var body: some View {
                List {
                    NavigationLink(destination: TermsView()) {
                        Text("Terms & Conditions")
                    }

                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                    }

                    NavigationLink(destination: placeholderView(title: "Licenses")) {
                        Text("Third-Party Licenses")
                    }

                    NavigationLink(destination: placeholderView(title: "Regulatory Information")) {
                        Text("Regulatory Information")
                    }
                }
                .navigationTitle("Legal Information")
            }
        }

        struct RateAppView: View {
            @Environment(\.presentationMode) var presentationMode
            @State private var rating = 0
            @State private var feedback = ""
            @State private var showThankYou = false

            var body: some View {
                VStack(spacing: 30) {
                    Text("How would you rate WealthBridge?")
                        .font(.title2)
                        .fontWeight(.bold)

                    // Star rating
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .font(.system(size: 40))
                                .foregroundColor(star <= rating ? .yellow : .gray)
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }

                    // Feedback text field
                    if rating > 0 {
                        VStack(alignment: .leading) {
                            Text("Tell us what you think:")
                                .font(.headline)

                            ZStack(alignment: .topLeading) {
                                if feedback.isEmpty {
                                    Text("Your feedback helps us improve...")
                                        .foregroundColor(.gray)
                                        .padding(8)
                                }

                                TextEditor(text: $feedback)
                                    .padding(4)
                                    .frame(height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal)

                        // Submit button
                        Button(action: {
                            showThankYou = true
                        }) {
                            Text("Submit Rating")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 200)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)
                    }

                    Spacer()
                }
                .padding(.top, 40)
                .navigationTitle("Rate WealthBridge")
                .alert(isPresented: $showThankYou) {
                    Alert(
                        title: Text("Thank You!"),
                        message: Text("Your feedback helps us improve WealthBridge for everyone."),
                        dismissButton: .default(Text("Done")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }
        }
