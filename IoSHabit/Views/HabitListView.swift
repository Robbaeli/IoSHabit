import SwiftUI
import SwiftData

struct HabitListView: View {
    @Query var habits: [Habit]

    var body: some View {
        List(habits) { habit in
            Text(habit.title)
        }
    }
}

#Preview {
    HabitListView()
        .modelContainer(for: Habit.self, inMemory: true)
}
