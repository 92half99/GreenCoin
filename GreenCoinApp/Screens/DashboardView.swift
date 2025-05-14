import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var statsManager: UserStatsManager
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TopBarView(title: "GreenCoin")
                ScrollView {
                    VStack(spacing: 24) {
                        GreetingView(
                            greeting: "Good morning, Emma!",
                            subtitle: "Ready to make a difference today?"
                        )
                        EnvironmentalImpactSection(
                            co2Saved: "\(statsManager.co2Saved) kg",
                            waterSaved: "\(statsManager.waterSaved) L",
                            wasteDiverted: "\(statsManager.wasteDiverted) kg"
                        )
                        WeeklyChallengesSection()
                        TabbedContentSection()
                        RecentActivitySection()
                    }
                    .padding(.vertical)
                }
                .background(Color(red: 0.98, green: 0.98, blue: 0.99).ignoresSafeArea())
            }
        }
    }
}


private struct GreetingView: View {
    let greeting: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(greeting)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
            Text(subtitle)
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
        }
        .padding(.horizontal)
    }
}


private struct EnvironmentalImpactSection: View {
    let co2Saved: String
    let waterSaved: String
    let wasteDiverted: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Environmental Impact")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                .padding(.horizontal)

            ImpactRow(
                icon: "leaf.fill",
                iconColor: .green,
                background: Color(red: 0.89, green: 0.98, blue: 0.91),
                label: "CO₂ Saved",
                value: co2Saved
            )
            ImpactRow(
                icon: "drop.fill",
                iconColor: .blue,
                background: Color(red: 0.86, green: 0.91, blue: 0.98),
                label: "Water Saved",
                value: waterSaved
            )
            ImpactRow(
                icon: "trash.fill",
                iconColor: .yellow,
                background: Color(red: 0.99, green: 0.95, blue: 0.80),
                label: "Waste Diverted",
                value: wasteDiverted
            )
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal)
    }

    private struct ImpactRow: View {
        let icon: String
        let iconColor: Color
        let background: Color
        let label: String
        let value: String

        var body: some View {
            HStack(spacing: 14) {
                Circle()
                    .fill(background)
                    .frame(width: 41, height: 41)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(iconColor)
                    )
                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(value)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 15)
            .background(background.opacity(0.3))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 5)
        }
    }
}


private struct WeeklyChallengesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Weekly Challenges")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                NavigationLink("View all") {
                    ChallengesView()
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 0.6, green: 0.68, blue: 0.64))
            }
            .padding(.horizontal)

            ChallengeCard(title: "Bike to Work Week",
                          subtitle: "Use bicycle instead of car for 5 days",
                          progress: 0.6)
            ChallengeCard(title: "Recycle Marathon",
                          subtitle: "Recycle 5 kg of waste materials",
                          progress: 0.4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 5)
        .padding(.horizontal)
    }

    private struct ChallengeCard: View {
        let title: String
        let subtitle: String
        let progress: Double

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                ProgressView(value: progress)
                    .accentColor(.green)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}


private struct TabbedContentSection: View {
    @State private var selectedTab = 0
    private let tabs = ["Activity History", "My Challenges", "Redeemed Rewards"]

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedTab) {
                ForEach(0..<tabs.count) { idx in
                    Text(tabs[idx]).tag(idx)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Group {
                if selectedTab == 0 {
                    RecentActivitySection()
                } else if selectedTab == 1 {
                    ChallengesView()
                } else {
                    RedeemedRewardsSection()  // Replace with your view for redeemed rewards
                }
            }
            .frame(height: 200)
            .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 5)
        .padding(.horizontal)
    }
}

// Placeholder for redeemed rewards tab
private struct RedeemedRewardsSection: View {
    var body: some View {
        Text("Redeemed Rewards")
            .font(.headline)
            .padding()
    }
}


private struct RecentActivitySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Activity")
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal)

            Text("No activities logged yet.\nStart by logging your first eco‑friendly action!")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 79)
                .background(Color.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal)
        }
    }
}
