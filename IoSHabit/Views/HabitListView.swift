import SwiftUI
import SwiftData

// Visar alla vanor i en lista
struct HabitListView: View {
    // Hämtar alla vanor från databasen automatiskt
    @Query var habits: [Habit]
    @Environment(\.modelContext) private var modelContext
    @Environment(NotificationManager.self) private var notificationManager
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    HabitRowView(habit: habit)
                }
                // Svep för att radera
                .onDelete { indexSet in
                    for index in indexSet {
                        notificationManager.cancel(for: habits[index])
                        modelContext.delete(habits[index])
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.mint.opacity(0.15))
            .navigationTitle("IOSHabit")
            // Visar tom-vy om det inte finns några vanor
            .overlay {
                if habits.isEmpty {
                    EmptyStateView {
                        showingAddSheet = true
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // Sheet glider upp från botten när showingAddSheet blir true
            .sheet(isPresented: $showingAddSheet) {
                AddHabitView()
            }
        }
    }
}

#Preview {
    HabitListView()
        .modelContainer(for: Habit.self, inMemory: true)
}
