//
//  PlanUpgradeView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-05-16.
//

import SwiftUI

struct PlanUpgradeView: View {
    @Binding var currentPlan: SubscriptionPlan
    @Binding var isPresented: Bool
    @State private var selectedPlan: SubscriptionPlan = .premium

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text("Choose Your Plan")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Unlock higher cashback rates and exclusive features")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top)

                    // Plan comparison
                    VStack(spacing: 15) {
                        ForEach([SubscriptionPlan.premium, SubscriptionPlan.gold]) { plan in
                            PlanComparisonCard(
                                plan: plan,
                                isSelected: selectedPlan == plan,
                                isCurrentPlan: plan == currentPlan
                            ) {
                                selectedPlan = plan
                            }
                        }
                    }

                    // Features comparison
                    featuresComparison

                    // Upgrade button
                    Button(action: {
                        currentPlan = selectedPlan
                        isPresented = false
                    }) {
                        Text("Upgrade to \(selectedPlan.name)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedPlan.color)
                            .cornerRadius(12)
                    }
                    .disabled(selectedPlan == currentPlan)
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }

    private var featuresComparison: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("What's Included")
                .font(.headline)

            VStack(spacing: 8) {
                FeatureComparisonRow(
                    feature: "Maximum Cashback",
                    freeValue: "1%",
                    premiumValue: "5%",
                    goldValue: "9%"
                )

                FeatureComparisonRow(
                    feature: "Cover Balance",
                    freeValue: "None",
                    premiumValue: "$30",
                    goldValue: "$400"
                )

                FeatureComparisonRow(
                    feature: "Investment Tools",
                    freeValue: "Basic",
                    premiumValue: "Advanced",
                    goldValue: "Premium"
                )

                FeatureComparisonRow(
                    feature: "Support",
                    freeValue: "Standard",
                    premiumValue: "Priority",
                    goldValue: "24/7 Dedicated"
                )
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(12)
    }
}

struct PlanComparisonCard: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    let isCurrentPlan: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 15) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(plan.name)
                            .font(.title2)
                            .fontWeight(.bold)

                        HStack(alignment: .bottom) {
                            Text(plan.price)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(plan.priceDescription)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }

                    Spacer()

                    if isCurrentPlan {
                        Text("CURRENT")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(plan.color.opacity(0.2))
                            .foregroundColor(plan.color)
                            .cornerRadius(6)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(plan.benefits, id: \.self) { benefit in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(plan.color)
                            Text(benefit)
                                .font(.subheadline)
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .background(
                isSelected ? plan.color.opacity(0.1) : Color("CardBackground")
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? plan.color : Color.clear, lineWidth: 2)
            )
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FeatureComparisonRow: View {
    let feature: String
    let freeValue: String
    let premiumValue: String
    let goldValue: String

    var body: some View {
        HStack {
            Text(feature)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 20) {
                Text(premiumValue)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .frame(width: 60)

                Text(goldValue)
                    .font(.subheadline)
                    .foregroundColor(.yellow)
                    .frame(width: 60)
            }
        }
        .padding(.vertical, 4)
    }
}


//MARK: preview

struct PlanUpgradeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Full screen preview
            PlanUpgradeView(
                currentPlan: .constant(.free),
                isPresented: .constant(true)
            )
            .previewDisplayName("Upgrade View")

            // Different starting plan
            PlanUpgradeView(
                currentPlan: .constant(.premium),
                isPresented: .constant(true)
            )
            .previewDisplayName("From Premium")
        }
    }
}

// PlanComparisonCard preview
struct PlanComparisonCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Selected state
            PlanComparisonCard(
                plan: .premium,
                isSelected: true,
                isCurrentPlan: false,
                action: {}
            )
            .padding()
            .previewDisplayName("Selected")

            // Current plan state
            PlanComparisonCard(
                plan: .gold,
                isSelected: false,
                isCurrentPlan: true,
                action: {}
            )
            .padding()
            .previewDisplayName("Current Plan")

            // Both plans
            VStack(spacing: 15) {
                PlanComparisonCard(
                    plan: .premium,
                    isSelected: true,
                    isCurrentPlan: false,
                    action: {}
                )

                PlanComparisonCard(
                    plan: .gold,
                    isSelected: false,
                    isCurrentPlan: false,
                    action: {}
                )
            }
            .padding()
            .previewDisplayName("Plan Comparison")
        }
        .previewLayout(.sizeThatFits)
    }
}

// FeatureComparisonRow preview
struct FeatureComparisonRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack(spacing: 8) {
                FeatureComparisonRow(
                    feature: "Maximum Cashback",
                    freeValue: "1%",
                    premiumValue: "5%",
                    goldValue: "9%"
                )

                FeatureComparisonRow(
                    feature: "Cover Balance",
                    freeValue: "None",
                    premiumValue: "$30",
                    goldValue: "$400"
                )

                FeatureComparisonRow(
                    feature: "Investment Tools",
                    freeValue: "Basic",
                    premiumValue: "Advanced",
                    goldValue: "Premium"
                )
            }
            .padding()
            .background(Color("CardBackground"))
            .cornerRadius(12)
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Feature Comparison")
    }
}
