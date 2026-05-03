import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Namn på vanan", text: $title)
            }
            .navigationTitle("Ny vana")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        let habit = Habit(title: title)
                        modelContext.insert(habit)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
        .modelContainer(for: Habit.self, inMemory: true)
}
