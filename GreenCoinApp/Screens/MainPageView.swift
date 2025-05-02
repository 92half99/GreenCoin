import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var pointsManager: PointsManager

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Welcome, Robyn")
                    .font(.titleRounded)
                    .padding(.top)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Your Goal: \(pointsManager.weeklyGoal) pts")
                        Text("Today: \(pointsManager.dailyPoints) pts")
                    }
                    Spacer()
                }
                .padding(.horizontal)

                ProgressRingView(progress: Double(pointsManager.dailyPoints) / Double(pointsManager.weeklyGoal))
                    .frame(width: 150, height: 150)
                    .padding(.top)

                Spacer()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
        }
        .overlay(
            FloatingChatButton()
        )
    }
}
