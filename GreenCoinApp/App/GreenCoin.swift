import SwiftUI

@main
struct GreenCoinApp: App {
    @StateObject private var pointsManager = PointsManager()
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("darkMode") var darkMode = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if !isLoggedIn {
                    LoginView()
                        .environmentObject(pointsManager)
                } else {
                    MainTabView()
                        .environmentObject(pointsManager)
                }
            }
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
