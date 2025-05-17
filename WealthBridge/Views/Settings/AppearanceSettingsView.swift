//
//  AppearanceSettingsView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-01.
//
// basic settings appearance

//import SwiftUI
//
//struct AppearanceSettingsView: View {
//    @Binding var isDarkModeEnabled: Bool
//    @State private var selectedTheme: Theme = .system
//
//    enum Theme: String, CaseIterable {
//        case light = "Light"
//        case dark = "Dark"
//        case system = "System"
//    }
//
//    var body: some View {
//        Form {
//            Section {
//                Picker("Theme", selection: $selectedTheme) {
//                    ForEach(Theme.allCases, id: \.self) { theme in
//                        Text(theme.rawValue)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.vertical, 8)
//            }
//
//            //            Section(header: Text("Customization")) {
//            //                NavigationLink(destination: AccentColorPickerView()) {
//            //                    Text("Accent Color")
//            //                }
//            //
//            //                NavigationLink(destination: FontSettingsView()) {
//            //                    Text("Font Size")
//            //                }
//            //            }
//            //        }
//            //        .navigationTitle("Appearance")
//            //        .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
