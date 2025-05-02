import SwiftUI

@main
struct GreenCoin: App {
  @StateObject private var pointsManager = PointsManager()

  var body: some Scene {
    WindowGroup {
      MainTabView()
        .environmentObject(pointsManager)
    }
  }
}
