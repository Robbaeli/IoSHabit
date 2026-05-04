import Foundation
import SwiftData

@Model
final class Habit {
    var id: UUID
    var title: String
    var createdAt: Date
    var completedDates: [Date]

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = .now
        self.completedDates = []
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
}
