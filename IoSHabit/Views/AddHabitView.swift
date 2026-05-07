import SwiftUI
import SwiftData

// Formulär för att skapa en ny vana, visas som sheet
struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(NotificationManager.self) private var notificationManager

    @State private var viewModel: HabitViewModel?
    @State private var title = ""
    @State private var hasTriedToSave = false
    @State private var reminderEnabled = false
    @State private var reminderTime = Calendar.current.date(from: DateComponents(hour: 8, minute: 0)) ?? .now

    // Kollar om titeln är tom eller bara mellanslag
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

                Section {
                    Toggle("Daglig påminnelse", isOn: $reminderEnabled)

                    if reminderEnabled {
                        DatePicker("Tid", selection: $reminderTime, displayedComponents: .hourAndMinute)
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
                        let reminder = reminderEnabled ? reminderTime : nil
                        if let habit = viewModel?.addHabit(name: title, reminderTime: reminder) {
                            notificationManager.scheduleDaily(for: habit)
                            dismiss()
                        }
                    }
                    .disabled(hasTriedToSave && isTitleEmpty)
                }
            }
            // Visar felmeddelande från VM om sparningen misslyckas
            .alert("Något gick fel", isPresented: Binding(
                get: { viewModel?.errorMessage != nil },
                set: { if !$0 { viewModel?.errorMessage = nil } }
            )) {
                Button("OK") { viewModel?.errorMessage = nil }
            } message: {
                Text(viewModel?.errorMessage ?? "")
            }
            .onAppear {
                if viewModel == nil {
                    viewModel = HabitViewModel(modelContext: modelContext)
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
        .modelContainer(for: Habit.self, inMemory: true)
}
