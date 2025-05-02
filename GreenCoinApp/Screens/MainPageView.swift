import SwiftUI

struct MainPageView: View {
  @EnvironmentObject var pointsManager: PointsManager
  @State private var showCustomAction = false

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        RoundedRectangle(cornerRadius: 15)
          .fill(Color(red: 91/255, green: 140/255, blue: 89/255))
          .frame(height: 60)
          .overlay(
            Text("GreenCoin")
              .font(.system(size: 24, weight: .bold))
              .foregroundColor(Color(red: 247/255, green: 234/255, blue: 191/255))
          )
          .padding(.top, 16)
          .padding(.horizontal)

        Text("Welcome, Robyn")
          .font(.title2)
          .fontWeight(.medium)
          .frame(maxWidth: .infinity)

        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text("Weekly Goal")
              .font(.system(size: 18, weight: .bold))
            Text("Today's points:")
              .font(.system(size: 16))
          }
          Spacer()
          VStack(alignment: .trailing, spacing: 4) {
            Text("\(pointsManager.weeklyGoal) points")
              .font(.system(size: 18, weight: .bold))
            Text("\(pointsManager.dailyPoints)")
              .font(.system(size: 16))
          }
        }
        .padding(.horizontal)

        ProgressRingView(
          progress: Double(pointsManager.dailyPoints) /
                   Double(pointsManager.weeklyGoal)
        )
        .frame(width: 150, height: 150)

        HStack(spacing: 24) {
          NavigationLink {
            ProgressPageView()
              .environmentObject(pointsManager)
          } label: {
            Text("Check your impact")
              .font(.system(size: 16, weight: .bold))
              .foregroundColor(.black)
              .padding(.vertical, 12)
              .padding(.horizontal, 24)
              .background(Color.white)
              .overlay(
                RoundedRectangle(cornerRadius: 25)
                  .stroke(Color.black, lineWidth: 1)
              )
              .cornerRadius(25)
          }

          VStack(spacing: 8) {
            Button {
              showCustomAction = true
            } label: {
              ZStack {
                Circle()
                  .fill(Color(red: 217/255, green: 200/255, blue: 124/255))
                  .frame(width: 50, height: 50)
                Image(systemName: "plus")
                  .font(.system(size: 24, weight: .bold))
                  .foregroundColor(.white)
              }
            }
            Text("Log impact")
              .font(.system(size: 14))
              .foregroundColor(.black)
          }
        }
        .padding(.top, 16)

        Spacer()
      }
      .sheet(isPresented: $showCustomAction) {
        CustomActionView()
          .environmentObject(pointsManager)
      }
      .navigationBarHidden(true)
    }
  }
}
