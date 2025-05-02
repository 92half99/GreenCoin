import SwiftUI

struct ProgressPageView: View {
  @EnvironmentObject var pointsManager: PointsManager

  var body: some View {
    VStack(spacing: 0) {
      // — Title Bar —
      RoundedRectangle(cornerRadius: 15)
        .fill(Color(red: 91/255, green: 140/255, blue: 89/255))
        .frame(height: 60)
        .overlay(
          Text("Progress")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color(red: 247/255, green: 234/255, blue: 191/255))
        )
        .padding(.top, 16)
        .padding(.horizontal)

      // — Stats —
      VStack(spacing: 20) {
        HStack(spacing: 20) {
          VStack(alignment: .leading, spacing: 8) {
            Text("CO₂ Saved")
              .font(.headline)
            Text("\(pointsManager.co2Saved) kg")
              .font(.title)
              .fontWeight(.semibold)
          }

          Spacer()

          VStack(alignment: .leading, spacing: 8) {
            Text("Active Days")
              .font(.headline)
            Text("\(pointsManager.daysActive)")
              .font(.title)
              .fontWeight(.semibold)
          }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)

        Spacer()
      }
      .padding(.top, 16)
      .padding(.bottom, 16)
    }
  }
}

