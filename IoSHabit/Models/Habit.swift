import Foundation
import SwiftData

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

    // Returnerar true om vanan redan är avcheckad idag
    var isCompletedToday: Bool {
        completedDates.contains { Calendar.current.isDateInToday($0) }
    }

    // Checkar av vanan för idag, men bara om den inte redan är avcheckad
    func completeToday() {
        guard !isCompletedToday else { return }
        completedDates.append(.now)
    }

    // Tar bort dagens avcheckning
    func uncompleteToday() {
        completedDates.removeAll { Calendar.current.isDateInToday($0) }
    }

    // Växlar mellan avcheckad/ej avcheckad
    func toggleToday() {
        if isCompletedToday {
            uncompleteToday()
        } else {
            completeToday()
        }
    }

    // Antal dagar i rad som vanan utförts, räknat bakåt från idag
    var currentStreak: Int {
        let calendar = Calendar.current

        // Gör om varje datum till bara "dag-precision" (tar bort klockslag)
        // och samla unika dagar i ett Set för snabb sökning
        let uniqueDays: Set<DateComponents> = Set(
            completedDates.map { calendar.dateComponents([.year, .month, .day], from: $0) }
        )

        var streak = 0
        var dayToCheck = calendar.startOfDay(for: .now)

        // Gå bakåt dag för dag och räkna så länge dagen finns i setet
        while uniqueDays.contains(calendar.dateComponents([.year, .month, .day], from: dayToCheck)) {
            streak += 1
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: dayToCheck) else { break }
            dayToCheck = previousDay
        }

        return streak
    }
}
