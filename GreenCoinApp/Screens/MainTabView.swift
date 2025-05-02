import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }

            SuggestedActionsView()
                .tabItem {
                    Label("Actions", systemImage: "checkmark.square.fill")
                }

            RewardsView()
                .tabItem {
                    Label("Rewards", systemImage: "gift.fill")
                }

            ProgressPageView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }

            ImpactExplorerView()
                .tabItem {
                    Label("Explore", systemImage: "globe.americas")
                }

            TipsView()
                .tabItem {
                    Label("Tips", systemImage: "leaf")
                }
        }
        .accentColor(.greenCoinPrimary)
    }
}
