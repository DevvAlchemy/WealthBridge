//
//  SubscriptionPlanRow.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct SubscriptionPlanRow: View {
    let plan: SubscriptionPlan
    let isCurrentPlan: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            // Plan indicator
            Circle()
                .fill(plan.color)
                .frame(width: 20, height: 20)

            // Plan details
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(plan.name)
                        .font(.headline)

                    if isCurrentPlan {
                        Text("CURRENT")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(plan.color.opacity(0.2))
                            .foregroundColor(plan.color)
                            .cornerRadius(4)
                    }
                }

                HStack {
                    Text(plan.price)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(plan.priceDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Text("Up to \(plan.maxCashback) cashback")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Action button
            if !isCurrentPlan {
                Button("Upgrade") {
                    action()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(plan.color)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isCurrentPlan ? plan.color : Color.clear, lineWidth: 2)
        )
    }
}


// MARK: this preview
struct SubscriptionPlanRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Current plan preview
            SubscriptionPlanRow(
                plan: .premium,
                isCurrentPlan: true,
                action: {}
            )
            .padding()
            .previewDisplayName("Current Plan")

            // Upgrade available plan
            SubscriptionPlanRow(
                plan: .gold,
                isCurrentPlan: false,
                action: {}
            )
            .padding()
            .previewDisplayName("Upgrade Available")

            // All plans in a list
            VStack(spacing: 12) {
                ForEach([SubscriptionPlan.free, .premium, .gold]) { plan in
                    SubscriptionPlanRow(
                        plan: plan,
                        isCurrentPlan: plan == .premium,
                        action: {}
                    )
                }
            }
            .padding()
            .previewDisplayName("All Plans")
        }
        .previewLayout(.sizeThatFits)
    }
}
