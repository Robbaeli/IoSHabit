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

    // MARK: - Kolla om en vana är utförd idag

    func isCompletedToday(_ habit: Habit) -> Bool {
        // Kontrollera om någon av datumen i completedDates
        // matchar dagens datum (ignorerar klockslag)
        habit.completedDates.contains { date in
            Calendar.current.isDateInToday(date)
        }
    }

    // MARK: - Markera en vana som utförd (eller ångra)

    func toggleCompletion(for habit: Habit) {
        if isCompletedToday(habit) {
            // Om redan utförd idag — ta bort dagens datum
            habit.completedDates.removeAll { date in
                Calendar.current.isDateInToday(date)
            }
        } else {
            // Annars — lägg till dagens datum
            habit.completedDates.append(.now)
        }
    }
}
