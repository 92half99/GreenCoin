import SwiftUI

struct SuggestedActionsView: View {
  @EnvironmentObject var pointsManager: PointsManager

  // Theme colors
  private let headerGreen   = Color(red: 91/255,  green: 140/255, blue: 89/255)
  private let headerGold    = Color(red: 247/255, green: 234/255, blue: 191/255)
  private let checkboxGreen = Color(red: 91/255,  green: 140/255, blue: 89/255)
  private let tickGold      = Color(red: 217/255, green: 200/255, blue: 124/255)
  private let customPoints  = Color(red: 217/255, green: 200/255, blue: 124/255)

  var body: some View {
    VStack(spacing: 0) {
      // ─── Title Bar ───────────────────────────────────
      RoundedRectangle(cornerRadius: 15)
        .fill(headerGreen)
        .frame(height: 60)
        .overlay(
          Text("Actions")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(headerGold)
        )
        .padding(.top, 16)
        .padding(.horizontal)

      // ─── Action List ─────────────────────────────────
      List {
        ForEach(pointsManager.suggestedActions) { action in
          HStack {
            // Custom colored checkbox
            ZStack {
              Rectangle()
                .fill(checkboxGreen)
                .frame(width: 24, height: 24)
              if action.isCompleted {
                Image(systemName: "checkmark")
                  .font(.system(size: 16, weight: .bold))
                  .foregroundColor(tickGold)
              }
            }
            .cornerRadius(4)

            Text(action.title)

            Spacer()

            Text("+\(action.points)")
              .foregroundColor(action.isCustom ? customPoints : .secondary)
          }
          .contentShape(Rectangle())
          .onTapGesture {
            pointsManager.completeAction(action)
          }
          .disabled(action.isCompleted)
        }
      }
      .listStyle(InsetGroupedListStyle())
    }
  }
}

