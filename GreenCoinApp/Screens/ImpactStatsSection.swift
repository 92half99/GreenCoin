import SwiftUI

struct ImpactStatsSection: View {
  let todayPoints: Int
  let weeklyGoal: Int
  let progress: Double

  var body: some View {
    VStack(spacing: 12) {
      HStack {
        Text("Today's Points:")
          .font(.system(size: 18))
        Spacer()
        Text("\(todayPoints)")
          .font(.system(size: 18, weight: .semibold))
      }
      HStack {
        Text("Weekly Goal:")
          .font(.system(size: 18))
        Spacer()
        Text("\(weeklyGoal)")
          .font(.system(size: 18, weight: .bold))
      }
      ZStack {
        Circle()
          .stroke(Color.gray.opacity(0.3), lineWidth: 10)
          .frame(width: 200, height: 200)
        Circle()
          .trim(from: 0, to: min(progress, 1.0))
          .stroke(
            Color.green,
            style: StrokeStyle(lineWidth: 10, lineCap: .round)
          )
          .rotationEffect(.degrees(-90))
          .frame(width: 200, height: 200)
          .animation(.easeInOut, value: progress)
        Text("\(Int(progress * 100))%")
          .font(.system(size: 28, weight: .semibold))
          .foregroundColor(.primary)
      }
    }
    .padding()
    .background(Color(.systemGray6))
    .cornerRadius(10)
  }
}
