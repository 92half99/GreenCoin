import SwiftUI

struct RewardsView: View {
  @EnvironmentObject var pointsManager: PointsManager

  var body: some View {
    VStack(spacing: 0) {
      // — Title Bar —
      RoundedRectangle(cornerRadius: 15)
        .fill(Color(red: 91/255, green: 140/255, blue: 89/255))
        .frame(height: 60)
        .overlay(
          Text("Rewards")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color(red: 247/255, green: 234/255, blue: 191/255))
        )
        .padding(.top, 16)
        .padding(.horizontal)

      // — Rewards List —
      List {
        Section(header: Text("Your Points: \(pointsManager.dailyPoints)")) {
          EmptyView()
        }

        Section(header: Text("Available Rewards")) {
          ForEach(pointsManager.rewards) { reward in
            HStack {
              Text(reward.name)
              Spacer()
              if reward.isRedeemed {
                Text("Redeemed")
                  .foregroundColor(.green)
              } else {
                Button {
                  pointsManager.redeemReward(reward)
                } label: {
                  Text("\(reward.cost) pts")
                }
                .disabled(pointsManager.dailyPoints < reward.cost)
              }
            }
          }
        }
      }
      .listStyle(InsetGroupedListStyle())
    }
  }
}

