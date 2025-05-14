import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var statsManager: UserStatsManager
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Image("Ellipse 32")
                        .resizable()
                        .frame(width: 87, height: 87)
                        .clipShape(Circle())
                        .background(
                            Circle()
                                .fill(Color(red: 0.93, green: 0.95, blue: 0.94))
                        )

                    Text("Emma Johnson")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(.black)

                    Text("@emma")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))

                    VStack(spacing: 4) {
                        HStack {
                            Text("Level 3")
                                .font(.system(size: 13, weight: .bold))
                            Spacer()
                            Text("Level 4")
                                .font(.system(size: 13, weight: .bold))
                        }
                        Image("Group 120")
                            .resizable()
                            .frame(height: 8)
                        Text("\(statsManager.totalPoints) / \(statsManager.nextLevelThreshold) SP")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.90, green: 1, blue: 0.91))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)

                // Stats Rows
                StatRow(label: "CO₂ Saved",   value: "\(statsManager.co2Saved) kg",      systemIcon: "leaf.fill")
                StatRow(label: "Water Saved", value: "\(statsManager.waterSaved) L",      systemIcon: "drop.fill")
                StatRow(label: "Activities",  value: "\(statsManager.daysActive)",       systemIcon: "figure.walk")

                // Account Management
                VStack(alignment: .leading, spacing: 12) {
                    Text("Account Management")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.0, green: 184/255, blue: 86/255))
                        .padding(.horizontal)

                    ForEach([
                        "Data & Privacy",
                        "Account Settings",
                        "Notifications",
                        "Password & Security"
                    ], id: \.self) { item in
                        HStack {
                            Text(item)
                                .font(.system(size: 14))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color(red: 0.98, green: 0.98, blue: 0.99).ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

private struct StatRow: View {
    let label: String
    let value: String
    let systemIcon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemIcon)
                .font(.system(size: 20))
                .frame(width: 32, height: 32)
                .background(Color.white)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
