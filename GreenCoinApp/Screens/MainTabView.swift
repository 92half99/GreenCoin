import SwiftUI

struct MainTabView: View {
  var body: some View {
    TabView {
      MainPageView()
        .tabItem {
          Image(systemName: "house.fill")
          Text("Home")
        }

      SuggestedActionsView()
        .tabItem {
          Image(systemName: "checkmark.square.fill")
          Text("Actions")
        }

      RewardsView()
        .tabItem {
          Image(systemName: "gift.fill")
          Text("Rewards")
        }

      ProgressPageView()
        .tabItem {
          Image(systemName: "chart.bar.fill")
          Text("Progress")
        }
    }
  }
}
