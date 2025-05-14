import SwiftUI

struct MainTabView: View {
    enum Tab {
        case home, challenges, log, marketplace, leaderboard
    }
    @State private var selection: Tab = .home

    var body: some View {
        TabView(selection: $selection) {
            DashboardView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(Tab.home)

            ChallengesView()
                .tabItem { Label("Challenges", systemImage: "flag.fill") }
                .tag(Tab.challenges)

            ActionLogView()
                .tabItem { Label("Log", systemImage: "pencil") }
                .tag(Tab.log)

            MarketplaceView()
                .tabItem { Label("Marketplace", systemImage: "cart.fill") }
                .tag(Tab.marketplace)

            LeaderboardView()
                .tabItem { Label("Leaderboard", systemImage: "chart.bar.fill") }
                .tag(Tab.leaderboard)
        }
        .accentColor(Color(red: 0.0, green: 0.5, blue: 0.0))
    }
}
