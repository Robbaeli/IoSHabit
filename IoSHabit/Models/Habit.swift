import Foundation
import SwiftData

// @Model gör att klassen sparas i databasen via SwiftData
@Model
final class Habit {
    var id: UUID
    var title: String
    var createdAt: Date
    var completedDates: [Date]
    var reminderTime: Date?

    init(title: String, reminderTime: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.createdAt = .now
        self.completedDates = []
        self.reminderTime = reminderTime
    }

    // Kollar om vanan är avcheckad idag
    var isCompletedToday: Bool {
        completedDates.contains { Calendar.current.isDateInToday($0) }
    }

    // Lägger till idag, men bara om det inte redan finns
    func completeToday() {
        guard !isCompletedToday else { return }
        completedDates.append(.now)
    }

    // Tar bort dagens avcheckning
    func uncompleteToday() {
        completedDates.removeAll { Calendar.current.isDateInToday($0) }
    }

    // Växlar mellan avcheckad och ej avcheckad
    func toggleToday() {
        if isCompletedToday {
            uncompleteToday()
        } else {
            completeToday()
        }
    }

    // Räknar antal dagar i rad bakåt från idag
    var currentStreak: Int {
        let calendar = Calendar.current

        // Samla alla unika dagar i ett Set (tar bort klockslag och dubbletter)
        let uniqueDays: Set<DateComponents> = Set(
            completedDates.map { calendar.dateComponents([.year, .month, .day], from: $0) }
        )

        var streak = 0
        var dayToCheck = calendar.startOfDay(for: .now)

        // Loopa bakåt dag för dag tills vi hittar en dag som saknas
        while uniqueDays.contains(calendar.dateComponents([.year, .month, .day], from: dayToCheck)) {
            streak += 1
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: dayToCheck) else { break }
            dayToCheck = previousDay
        }

        return streak
    }
}
