//
//  ContentView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "dollarsign.bank.building.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("WealthBridge")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
