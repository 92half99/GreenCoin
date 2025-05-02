import SwiftUI

final class PointsManager: ObservableObject {
  @Published var dailyPoints: Int = 0
  @Published var weeklyGoal: Int = 1000
  @Published var co2Saved: Int = 0
  @Published var daysActive: Int = 0

  @Published var suggestedActions: [ActionItem] = [
    ActionItem(title: "Ride bike to work", points: 10, isCompleted: false, isCustom: false),
    ActionItem(title: "Ride bike home",    points: 10, isCompleted: false, isCustom: false),
    ActionItem(title: "Donate clothes",    points: 20, isCompleted: false, isCustom: false),
    ActionItem(title: "Shop sustainably",  points: 5,  isCompleted: false, isCustom: false)
  ]

  @Published var rewards: [RewardItem] = [
    RewardItem(name: "Nike Renew Shoes",      cost: 500),
    RewardItem(name: "Tesla Test Drive",      cost: 3000),
    RewardItem(name: "Reusable Water Bottle", cost: 200)
  ]

  private var activeDates: Set<String> = []

  struct ActionItem: Identifiable {
    let id = UUID()
    let title: String
    let points: Int
    var isCompleted: Bool
    let isCustom: Bool
  }

  struct RewardItem: Identifiable {
    let id = UUID()
    let name: String
    let cost: Int
    var isRedeemed: Bool = false
  }

  init() {
    self.dailyPoints = 0
    self.co2Saved     = 0
    self.daysActive   = 0
  }

  private func recordActiveDay() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let todayStr = formatter.string(from: Date())

    if !activeDates.contains(todayStr) {
      activeDates.insert(todayStr)
      daysActive = activeDates.count
    }
  }

  // MARK: - Actions

  func completeAction(_ action: ActionItem) {
    guard
      let idx = suggestedActions.firstIndex(where: { $0.id == action.id }),
      !suggestedActions[idx].isCompleted
    else { return }

    suggestedActions[idx].isCompleted = true

    let pts = suggestedActions[idx].points
    dailyPoints += pts
    co2Saved   += pts

    recordActiveDay()
  }

  /// Add a custom action and mark it complete
  func addCustomAction(title: String, points: Int) {
    let action = ActionItem(
      title: title,
      points: points,
      isCompleted: true,
      isCustom: true
    )
    suggestedActions.append(action)

    dailyPoints += points
    co2Saved   += points

    recordActiveDay()
  }

  // MARK: - Rewards

  func redeemReward(_ reward: RewardItem) {
    guard
      let idx = rewards.firstIndex(where: { $0.id == reward.id }),
      !rewards[idx].isRedeemed,
      dailyPoints >= rewards[idx].cost
    else { return }

    dailyPoints -= rewards[idx].cost
    rewards[idx].isRedeemed = true
  }
}
