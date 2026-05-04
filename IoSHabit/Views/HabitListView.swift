import SwiftUI
import SwiftData

struct HabitListView: View {
    @Query var habits: [Habit]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    HabitRowView(habit: habit)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(habits[index])
                    }
                }
            }
            .navigationTitle("Mina vanor")
            .overlay {
                if habits.isEmpty {
                    ContentUnavailableView(
                        "Inga vanor ännu",
                        systemImage: "list.bullet.clipboard",
                        description: Text("Tryck + för att lägga till din första vana")
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
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
