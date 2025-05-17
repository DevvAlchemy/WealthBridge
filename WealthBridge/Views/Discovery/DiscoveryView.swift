//
//  DiscoveryView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-01-31.
//

// DiscoveryView.swift
import SwiftUI

struct DiscoveryView: View {
    // MARK: - Properties
    @State private var currentPlan: SubscriptionPlan = .free
    @State private var showUpgradeSheet = false
    @State private var selectedCategory: OfferCategory = .all

    // Sample data for offers and plans
    private let featuredOffers: [CashbackOffer] = [
        CashbackOffer(
            id: 1,
            merchant: "Amazon",
            cashbackRate: 5.0,
            category: .shopping,
            logoName: "amazon-logo",
           description: "Get 5% cashback on all purchases",
            validUntil: "Dec 31, 2025"
        ),
        CashbackOffer(
            id: 2,
            merchant: "Spotify",
            cashbackRate: 9.0,
            category: .entertainment,
            logoName: "spotify-logo",
            description: "Earn 9% back on music streaming",
            validUntil: "Dec 31, 2025"
        ),
        CashbackOffer(
            id: 3,
            merchant: "Uber",
            cashbackRate: 7.5,
            category: .transport,
            logoName: "uber-logo",
            description: "Get 7.5% cashback on rides",
            validUntil: "Dec 31, 2025"
        )
    ]

    private let subscriptionPlans: [SubscriptionPlan] = [
        .free,
        .premium,
        .gold
    ]

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Current plan display
                    currentPlanCard

                    // Category filter
                    categoryFilter

                    // Featured cashback offers
                    featuredOffersSection

                    // Subscription plans comparison
                    subscriptionPlansSection

                    // Financial tools
                    financialToolsSection
                }
                .padding()
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.large)
            .background(Color("backgroundColor").ignoresSafeArea())
            .sheet(isPresented: $showUpgradeSheet) {
                PlanUpgradeView(
                    currentPlan: $currentPlan,
                    isPresented: $showUpgradeSheet
                )
            }
        }
    }

    // MARK: - Subviews
    private var currentPlanCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Current Plan")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(currentPlan.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(currentPlan.color)
                }

                Spacer()

                Button("Upgrade") {
                    showUpgradeSheet = true
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
            }

            // Plan benefits preview
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(currentPlan.benefits.prefix(3)), id: \.self) { benefit in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(benefit)
                            .font(.subheadline)
                    }
                }

                if currentPlan.benefits.count > 3 {
                    Text("+ \(currentPlan.benefits.count - 3) more benefits")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color("CardBackground"))
        .cornerRadius(16)
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(OfferCategory.allCases, id: \.self) { category in
                    Button(action: {
                        withAnimation {
                            selectedCategory = category
                        }
                    }) {
                        VStack {
                            Image(systemName: category.iconName)
                                .font(.title2)
                                .foregroundColor(selectedCategory == category ? .white : .blue)

                            Text(category.displayName)
                                .font(.caption)
                                .foregroundColor(selectedCategory == category ? .white : .primary)
                        }
                        .padding()
                        .background(
                            selectedCategory == category ?
                                Color.blue : Color("CardBackground")
                        )
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private var featuredOffersSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Featured Cashback")
                    .font(.title2)
                    .fontWeight(.bold)

                Spacer()

                Button("See All") {
                    // Navigate to all offers
                }
                .foregroundColor(.blue)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(filteredOffers) { offer in
                        CashbackOfferCard(offer: offer)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var subscriptionPlansSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Subscription Plans")
                .font(.title2)
                .fontWeight(.bold)

            Text("Unlock higher cashback rates and exclusive features")
                .font(.subheadline)
                .foregroundColor(.gray)

            VStack(spacing: 12) {
                ForEach(subscriptionPlans) { plan in
                    SubscriptionPlanRow(
                        plan: plan,
                        isCurrentPlan: plan == currentPlan
                    ) {
                        if plan != currentPlan {
                            showUpgradeSheet = true
                        }
                    }
                }
            }
        }
    }

    private var financialToolsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Financial Tools")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 12) {
                FinancialToolCard(
                    title: "Credit Builder",
                    description: "Build your credit score with our line of credit",
                    iconName: "creditcard.fill",
                    color: .green
                )

                FinancialToolCard(
                    title: "Investment Advisor",
                    description: "Get AI-powered investment recommendations",
                    iconName: "chart.line.uptrend.xyaxis",
                    color: .purple
                )

                FinancialToolCard(
                    title: "Budgeting Assistant",
                    description: "Smart budgeting with automated insights",
                    iconName: "dollarsign.circle.fill",
                    color: .orange
                )
            }
        }
    }

    // MARK: - Computed Properties
    private var filteredOffers: [CashbackOffer] {
        if selectedCategory == .all {
            return featuredOffers
        } else {
            return featuredOffers.filter { $0.category == selectedCategory }
        }
    }
}

// MARK: - Preview
//struct DiscoveryView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoveryView()
//    }
//}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Main view preview
            DiscoveryView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Discovery View - Dark")

            DiscoveryView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Discovery View - Light")
        }
    }
}
