//
//  ContactCircle.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-16.
//

import SwiftUI

struct ContactCircle: View {
    let contact: Contact
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(contact.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.yellow, lineWidth: 2)
                        )
                Text(contact.name)
                    .font(.caption)
                    .foregroundColor(.gray)

            }
        }
    }
}


struct ContactCircle_Previews: PreviewProvider {
    static var previews: some View {
        ContactCircle(
            contact: Contact(id: 1, name: "John", image: "person1"),
            action: {}
        )
    }
}
