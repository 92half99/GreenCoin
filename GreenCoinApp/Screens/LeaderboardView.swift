import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject private var statsManager: UserStatsManager
    struct LeaderboardEntry: Identifiable {
        let id = UUID()
        let rank: Int
        let user: String
        let level: String
        let points: Int
    }
    struct Badge: Identifiable {
        let id = UUID()
        let name: String
        let imageName: String
        let earned: Bool
    }

    private let entries: [LeaderboardEntry] = [
        .init(rank: 1, user: "iOS Innovation", level: "Level 10", points: 50),
        .init(rank: 2, user: "Green Guru",    level: "Level 9",  points: 45),
        .init(rank: 3, user: "Eco Warrior",   level: "Level 8",  points: 40)
    ]
    @State private var period = "Month"
    private let periods = ["Week", "Month", "Year"]

    private let badges: [Badge] = [
        .init(name: "Recycling Pro",   imageName: "badge_recycling", earned: true),
        .init(name: "Cycle Hero",      imageName: "badge_cycle",     earned: true),
        .init(name: "Water Saver",     imageName: "badge_water",     earned: false),
        .init(name: "Green Thumb",     imageName: "badge_thumb",     earned: true),
        .init(name: "Energy Wizard",   imageName: "badge_energy",    earned: false)
    ]

    var body: some View {
        VStack(spacing: 0) {
            TopBarView(title: "Leaderboard")

            ScrollView {
                VStack(spacing: 24) {

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Community Leaderboard")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.green)

                        HStack {
                            Text("Rank").font(.caption).foregroundColor(.gray).frame(width: 40, alignment: .leading)
                            Text("User").font(.caption).foregroundColor(.gray).frame(minWidth: 80, alignment: .leading)
                            Text("Level").font(.caption).foregroundColor(.gray).frame(minWidth: 60, alignment: .leading)
                            Text("Points").font(.caption).foregroundColor(.gray).frame(minWidth: 60, alignment: .leading)
                            Spacer()
                        }

                        ForEach(entries) { e in
                            HStack {
                                Text("\(e.rank)").bold().frame(width: 40, alignment: .leading)
                                Text(e.user).frame(minWidth: 80, alignment: .leading)
                                Text(e.level).frame(minWidth: 60, alignment: .leading)
                                Text("\(e.points)").frame(minWidth: 60, alignment: .leading)
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.99, blue: 0.96))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Your Impact")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                            Picker("", selection: $period) {
                                ForEach(periods, id: \.self) { p in
                                    Text(p).tag(p)
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 200)
                        }

                        Image("leaderboardChart")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 140)
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.99, blue: 0.96))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    // YOUR BADGES
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Your Badges")
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                            Button("View All") { }
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.green)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(badges) { badge in
                                    VStack {
                                        Image(badge.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .opacity(badge.earned ? 1.0 : 0.3)
                                        Text(badge.name)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                    .background(Color(red: 0.95, green: 0.99, blue: 0.96))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)

                }
                .padding(.vertical)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
