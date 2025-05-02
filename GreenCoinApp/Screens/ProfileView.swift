import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = true
    @AppStorage("darkMode") var darkMode = false
    @EnvironmentObject var pointsManager: PointsManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("👤 Personal Info")) {
                    Text("Name: Robyn")
                    Text("Email: robyn@example.com")
                }

                Section(header: Text("🎯 Weekly Goal")) {
                    Stepper("Goal: \(pointsManager.weeklyGoal) pts", value: $pointsManager.weeklyGoal, in: 100...5000, step: 100)
                }

                Section(header: Text("🎖️ Achievements")) {
                    Text("You’ve completed \(pointsManager.daysActive) active days")
                    Text("CO₂ Saved: \(pointsManager.co2Saved) kg")
                }

                Section(header: Text("⚙️ Settings")) {
                    Toggle("Dark Mode", isOn: $darkMode)
                    Button("🔓 Log Out") {
                        isLoggedIn = false
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Your Profile")
        }
    }
}
