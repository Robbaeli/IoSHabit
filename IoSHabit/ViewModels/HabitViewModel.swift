import Foundation
import SwiftData

// @Observable gör att SwiftUI automatiskt uppdaterar vyer
// när data i denna klass ändras.
@Observable
final class HabitViewModel {

    // ModelContext är kopplingen till SwiftData-databasen.
    // Vi använder den för att spara, hämta och ta bort data.
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Lägg till en ny vana

    func addHabit(title: String) {
        let habit = Habit(title: title)
        // insert() lägger till objektet i databasen
        modelContext.insert(habit)
    }

    // MARK: - Ta bort en vana

    func deleteHabit(_ habit: Habit) {
        // delete() tar bort objektet från databasen
        modelContext.delete(habit)
    }

    // MARK: - Markera en vana som utförd (eller ångra)

    func toggleCompletion(for habit: Habit) {
        // Logiken lever nu på Habit-modellen själv
        habit.toggleToday()
    }
}
