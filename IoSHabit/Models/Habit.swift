import Foundation
import SwiftData

// @Model gör att klassen sparas i databasen via SwiftData
@Model
final class Habit {
    var id: UUID = UUID()
    var name: String
    var createdAt: Date
    var completedDates: [Date] = []
    var reminderTime: Date?

    init(name: String, reminderTime: Date? = nil) {
        self.name = name
        self.createdAt = .now
        self.reminderTime = reminderTime
    }

    // Kollar om vanan är avcheckad idag
    var isCompletedToday: Bool {
        completedDates.contains { Calendar.current.isDateInToday($0) }
    }

    // Räknar antal dagar i rad, tillåter att idag inte är avcheckad ännu
    var currentStreak: Int {
        let calendar = Calendar.current

        // Normalisera alla datum till kl 00:00 och ta bort dubbletter
        let uniqueDays = Set(completedDates.map { calendar.startOfDay(for: $0) })
        let sortedDays = uniqueDays.sorted(by: >)

        guard let latest = sortedDays.first else {
            return 0
        }

        // Om senaste inte är idag eller igår är streaken bruten
        let today = calendar.startOfDay(for: Date())
        let daysSinceLatest = calendar.dateComponents([.day], from: latest, to: today).day ?? 0

        if daysSinceLatest > 1 {
            return 0
        }

        // Räkna bakåt dag för dag
        var streak = 1
        var expected = calendar.date(byAdding: .day, value: -1, to: latest)!

        for day in sortedDays.dropFirst() {
            if day == expected {
                streak += 1
                expected = calendar.date(byAdding: .day, value: -1, to: expected)!
            } else {
                break
            }
        }

        return streak
    }
}
