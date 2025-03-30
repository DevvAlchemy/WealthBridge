//
//  TabView.swift
//  WealthBridge
//
//  Created by Royal K on 2025-02-14.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0 //State to keep track of the current tab
    var body: some View {
        TabView(selection: $selectedTab) {
            //different tabs begin
            HomeView()
                .tabItem{
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)

            // Analytics Tab
            AnalyticsView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "chart.bar.fill" : "chart.bar")
                    Text("Analytics")
                }
                .tag(1)

            // Transfer Tab
//            TransferView()
//                .tabItem {
//                    Image(systemName: selectedTab == 2 ? "dollarsign.circle.fill" : "dollarsign.circle")
//                    Text("Transfer")
//                }
//                .tag(2)

            // Discovery Tab
            DiscoveryView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "square.grid.2x2.fill" : "square.grid.2x2.fill")
                    Text("Discovery")
                }
                .tag(3)

            // Settings Tab
            SettingsView()
                .tabItem {
                    Image(
                        systemName: selectedTab == 4 ? "gearshape.fill" : "gearshape"
                    )
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(.orange)//active tab colour
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
