import SwiftUI
import Charts

struct HomeView: View {
    @EnvironmentObject var pointsManager: PointsManager
    @State private var navigateToActions = false

    struct ChartData: Identifiable {
        let id = UUID()
        let label: String
        let value: Double
    }

    var chartData: [ChartData] {
        [
            ChartData(label: "CO₂ Saved", value: Double(pointsManager.co2Saved)),
            ChartData(label: "Today’s Points", value: Double(pointsManager.dailyPoints)),
            ChartData(label: "Days Active", value: Double(pointsManager.daysActive))
        ]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header with welcome and profile
                    HStack {
                        Text("🌱 Welcome, Robyn!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.greenCoinPrimary)
                        Spacer()
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)

                    // Sustainability quote
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quote of the Day")
                            .font(.headline)
                        Text("“The greatest threat to our planet is the belief that someone else will save it.” – Robert Swan")
                            .font(.body)
                            .italic()
                    }
                    .padding()
                    .background(Color.greenCoinPrimary.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Progress Chart
                    VStack(spacing: 20) {
                        Text("Progress Overview")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Chart(chartData) { item in
                            SectorMark(
                                angle: .value("Value", item.value),
                                innerRadius: .ratio(0.5),
                                angularInset: 2.0
                            )
                            .foregroundStyle(by: .value("Label", item.label))
                        }
                        .frame(height: 250)
                        .padding()
                        .background(Color.greenCoinPrimary.opacity(0.05))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // Navigate to Actions Tab
                    NavigationLink(destination: SuggestedActionsView(), isActive: $navigateToActions) {
                        EmptyView()
                    }

                    // Log Action Button
                    Button(action: {
                        navigateToActions = true
                    }) {
                        Text("📝 Log Action")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.greenCoinPrimary)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    Spacer(minLength: 50)
                }
                .padding(.top)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
