//
//  ProfileView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-17.
//

// Views/Settings/ProfileView.swift
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var profile: UserProfile

    @State private var editedFirstName: String
    @State private var editedLastName: String
    @State private var editedEmail: String
    @State private var editedPhoneNumber: String
    @State private var showImagePicker = false

    // Initialize State variables
    init(profile: Binding<UserProfile>) {
        self._profile = profile
        self._editedFirstName = State(initialValue: profile.wrappedValue.firstName)
        self._editedLastName = State(initialValue: profile.wrappedValue.lastName)
        self._editedEmail = State(initialValue: profile.wrappedValue.email)
        self._editedPhoneNumber = State(initialValue: profile.wrappedValue.phoneNumber)
    }

    var body: some View {
        NavigationView {
            Form {
                // Profile image
                Section {
                    HStack {
                        Spacer()

                        Button(action: {
                            showImagePicker = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("CardBackground"))
                                    .frame(width: 100, height: 100)

                                if let profileImage = profile.profileImage {
                                    Image(profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } else {
                                    Text("\(String(profile.firstName.prefix(1)))\(String(profile.lastName.prefix(1)))")
                                        .font(.title)
                                        .foregroundColor(.primary)
                                }

                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .offset(x: 35, y: 35)
                            }
                        }

                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }

                // Personal information
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $editedFirstName)
                    TextField("Last Name", text: $editedLastName)
                    TextField("Email", text: $editedEmail)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                    TextField("Phone Number", text: $editedPhoneNumber)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)

                    DatePicker(
                        "Date of Birth",
                        selection: $profile.dateOfBirth,
                        displayedComponents: .date
                    )
                }

                // Save button
                Section {
                    Button(action: saveChanges) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            // ImagePicker would go here in a real app
            // .sheet(isPresented: $showImagePicker) {
            //     ImagePicker(selectedImage: $selectedImage)
            // }
        }
    }

    private func saveChanges() {
        profile.firstName = editedFirstName
        profile.lastName = editedLastName
        profile.email = editedEmail
        profile.phoneNumber = editedPhoneNumber

        presentationMode.wrappedValue.dismiss()
    }
}
