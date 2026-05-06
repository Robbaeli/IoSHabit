import Foundation
import SwiftData

// Mellanlager mellan vyerna och datan, hanterar logik för vanor
@Observable
final class HabitViewModel {

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // Skapar en ny vana och sparar i databasen
    func addHabit(title: String) {
        let habit = Habit(title: title)
        modelContext.insert(habit)
    }

    // Tar bort en vana från databasen
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)
    }

    // Växlar avcheckning via Habit-modellens egen funktion
    func toggleCompletion(for habit: Habit) {
        habit.toggleToday()
    }
}
