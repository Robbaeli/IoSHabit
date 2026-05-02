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
}
