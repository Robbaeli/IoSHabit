import SwiftUI
import SwiftData

struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var hasTriedToSave = false

    private var isTitleEmpty: Bool {
        title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Namn på vanan", text: $title)
                } footer: {
                    if hasTriedToSave && isTitleEmpty {
                        Text("Du måste ange ett namn för vanan.")
                            .foregroundStyle(.red)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.mint.opacity(0.15))
            .navigationTitle("Ny vana")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        hasTriedToSave = true
                        guard !isTitleEmpty else { return }
                        let habit = Habit(title: title)
                        modelContext.insert(habit)
                        dismiss()
                    }
                    .disabled(hasTriedToSave && isTitleEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
        .modelContainer(for: Habit.self, inMemory: true)
}
