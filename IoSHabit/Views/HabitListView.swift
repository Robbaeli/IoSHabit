import SwiftUI
import SwiftData

struct HabitListView: View {
    @Query var habits: [Habit]
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List(habits) { habit in
                Text(habit.title)
            }
            .navigationTitle("Mina vanor")
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
