import SwiftUI

struct ContentView: View {
    @StateObject private var pointsManager = UserStatsManager()
    
    var body: some View {
        MainTabView()
            .environmentObject(pointsManager)
    }
}
