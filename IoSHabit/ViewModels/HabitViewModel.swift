import Foundation
import SwiftData

// Mellanlager mellan vyerna och datan, hanterar logik för vanor
@Observable
final class HabitViewModel {

    var errorMessage: String?

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // Skapar en ny vana med validering och sparar i databasen
    func addHabit(name: String, reminderTime: Date? = nil) -> Habit? {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Vanans namn kan inte vara tomt."
            return nil
        }

        let habit = Habit(name: name, reminderTime: reminderTime)
        modelContext.insert(habit)

        do {
            try modelContext.save()
        } catch {
            errorMessage = "Kunde inte spara vanan: \(error.localizedDescription)"
            return nil
        }

        return habit
    }

    // Tar bort en vana från databasen
    func deleteHabit(_ habit: Habit) {
        modelContext.delete(habit)

        do {
            try modelContext.save()
        } catch {
            errorMessage = "Kunde inte ta bort vanan: \(error.localizedDescription)"
        }
    }

    // Växlar avcheckning och sparar direkt för att fånga eventuella fel
    func toggleToday(for habit: Habit) {
        let calendar = Calendar.current

        if let todayIndex = habit.completedDates.firstIndex(where: {
            calendar.isDateInToday($0)
        }) {
            // Redan utförd idag ta bort
            habit.completedDates.remove(at: todayIndex)
        } else {
            // Inte utförd idag lägg till
            habit.completedDates.append(Date())
        }

        do {
            try modelContext.save()
        } catch {
            errorMessage = "Kunde inte spara: \(error.localizedDescription)"
        }
    }
}
