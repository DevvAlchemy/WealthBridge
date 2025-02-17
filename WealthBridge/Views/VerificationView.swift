//
//  VerificationView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct VerificationView: View {
   @Environment(\.dismiss) private var dismiss
   @StateObject private var viewModel = VerificationViewModel()

   // OTP text fields
   @FocusState private var focusedField: Int?

   var body: some View {
       NavigationView {
           ZStack {
               VStack(spacing: 30) {

                   VStack(spacing: 12) {
                       Text("Verification Code")
                           .font(.title2)
                           .fontWeight(.bold)

                       Text("Enter the 6-digit code sent to\n\(viewModel.maskedEmail)")
                           .multilineTextAlignment(.center)
                           .foregroundColor(.gray)
                   }
                   .padding(.top, 20)

                   // OTP Input Fields
                   HStack(spacing: 12) {
                       ForEach(0..<6) { index in
                           OTPTextField(text: $viewModel.otpFields[index],
                                      focused: focusedField == index)
                               .focused($focusedField, equals: index)
                               .onChange(of:viewModel.otpFields[index]) { newValue in
                                   if newValue.count == 1 && index < 5 {
                                       focusedField = index + 1
                                   }
                               }
                       }
                   }
                   .padding(.horizontal)

                   // Error message
                   if !viewModel.errorMessage.isEmpty {
                       Text(viewModel.errorMessage)
                           .foregroundColor(.red)
                           .font(.caption)
                   }

                   // Verify Button
                   Button(action: {
                       Task {
                           await viewModel.verifyCode()
                       }
                   }) {
                       Text("Verify")
                           .fontWeight(.semibold)
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.blue)
                           .cornerRadius(10)
                   }
                   .padding(.horizontal)
                   .disabled(viewModel.isLoading)

                   // Resend code button
                   Button(action: {
                       Task {
                           await viewModel.resendCode()
                       }
                   }) {
                       HStack {
                           Text("Didn't receive the code?")
                               .foregroundColor(.gray)
                           Text("Resend")
                               .foregroundColor(.blue)
                       }
                       .font(.subheadline)
                   }
                   .disabled(viewModel.isLoading || viewModel.resendTimer > 0)

                   if viewModel.resendTimer > 0 {
                       Text("Resend code in \(viewModel.resendTimer)s")
                           .font(.caption)
                           .foregroundColor(.gray)
                   }

                   Spacer()
               }

               if viewModel.isLoading {
                   Color.black.opacity(0.3)
                       .ignoresSafeArea()
                   ProgressView()
               }
           }
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                   Button(action: { dismiss() }) {
                       Image(systemName: "xmark")
                           .foregroundColor(.gray)
                   }
               }
           }
       }
   }
}

// OTP Text Field Component
struct OTPTextField: View {
   @Binding var text: String
   var focused: Bool

   var body: some View {
       TextField("", text: $text)
           .keyboardType(.numberPad)
           .multilineTextAlignment(.center)
           .frame(width: 45, height: 45)
           .background(
               RoundedRectangle(cornerRadius: 8)
                   .stroke(focused ? Color.blue : Color.gray, lineWidth: 1)
           )
           .onChange(of: text) { newValue in
               if newValue.count > 1 {
                   text = String(newValue.prefix(1))
               }
           }
   }
}

// VerificationViewModel
class VerificationViewModel: ObservableObject {
   @Published var otpFields: [String] = Array(repeating: "", count: 6)
   @Published var errorMessage = ""
   @Published var isLoading = false
   @Published var resendTimer = 0

   var maskedEmail: String = "e***@example.com" // This would come from your auth flow

   private var resendTimerTask: Task<Void, Never>?

   func verifyCode() async {
       let code = otpFields.joined()
       guard code.count == 6 else {
           errorMessage = "Please enter all digits"
           return
       }

       isLoading = true

       do {
           // Simulate verification delay
           try await Task.sleep(nanoseconds: 2 * 1_000_000_000)

           await MainActor.run {
               isLoading = false
               // Handle successful verification
           }
       } catch {
           await MainActor.run {
               isLoading = false
               errorMessage = "Invalid verification code"
           }
       }
   }

   func resendCode() async {
       isLoading = true

       do {
           // Simulate resend delay
           try await Task.sleep(nanoseconds: 1 * 1_000_000_000)

           await MainActor.run {
               isLoading = false
               startResendTimer()
           }
       } catch {
           await MainActor.run {
               isLoading = false
               errorMessage = "Failed to resend code"
           }
       }
   }

   private func startResendTimer() {
       resendTimer = 30
       resendTimerTask?.cancel()

       resendTimerTask = Task {
           while resendTimer > 0 {
               try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
               await MainActor.run {
                   resendTimer -= 1
               }
           }
       }
   }
}

// Preview Provider
struct VerificationView_Previews: PreviewProvider {
   static var previews: some View {
       VerificationView()
   }
}
