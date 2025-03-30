//
//  TabButton.swift
//  WealthBridge
//
//  Created by Royal K on 2025-03-19.
//
// Components/TabButton.swift

import SwiftUI

struct TabButton: View {
    // Properties
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? .blue : .gray)

                // Indicator bar
                Rectangle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(height: 3)
                    .cornerRadius(1.5)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabButton(title: "Selected", isSelected: true) {}
            TabButton(title: "Not Selected", isSelected: false) {}
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
