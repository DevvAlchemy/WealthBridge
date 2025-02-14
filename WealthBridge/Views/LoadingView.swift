//
//  LoadinView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// LoadingView.swift
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}


#Preview {
    LoadingView()
}
