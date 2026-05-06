import SwiftUI
import SwiftData

struct HabitListView: View {
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
