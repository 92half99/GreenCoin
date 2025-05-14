struct WeeklyChallenge: Identifiable {
    let id = UUID()
    let title: String
    let goalDays: Int
    var daysCompleted: Int
}

import Foundation
import SwiftUI

final class UserStatsManager: ObservableObject {

    @Published var dailyPoints: Int = 0

    @Published var totalPoints: Int = 0

    @Published var daysActive: Int = 0

    @Published var co2Saved: Double = 0.0

    @Published var waterSaved: Double = 0.0

    @Published var wasteDiverted: Double = 0.0

    @Published var nextLevelThreshold: Int = 600

    // Tracks weekly challenges and progress
    @Published var weeklyChallenges: [WeeklyChallenge] = [
        WeeklyChallenge(title: "Bike to Work Week", goalDays: 5, daysCompleted: 0)
    ]

    func redeem(points cost: Int) {
        guard dailyPoints >= cost else { return }
        dailyPoints -= cost
        totalPoints -= cost
    }

    func logAction(points: Int,
                   co2: Double = 0.0,
                   water: Double = 0.0,
                   waste: Double = 0.0) {
        dailyPoints += points
        totalPoints += points

        co2Saved += co2
        waterSaved += water
        wasteDiverted += waste

        incrementActiveDaysIfNeeded()
    }


    private var lastActiveDate: Date?

    private func incrementActiveDaysIfNeeded() {
        let today = Calendar.current.startOfDay(for: Date())
        if lastActiveDate != today {
            daysActive += 1
            lastActiveDate = today
        }
    }
}
