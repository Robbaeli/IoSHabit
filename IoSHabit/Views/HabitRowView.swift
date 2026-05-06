import SwiftUI

// En rad i listan som visar en vana med ikon, namn och streak
struct HabitRowView: View {
    var habit: Habit

    var body: some View {
        HStack(spacing: 12) {
            // Bock-ikon om avcheckad, tom cirkel annars
            Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(habit.isCompletedToday ? .green : .gray)
                .onTapGesture {
                    withAnimation {
                        habit.toggleToday()
                    }
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(habit.title)
                    .font(.headline)
                    .strikethrough(habit.isCompletedToday, color: .green)

                if habit.currentStreak > 0 {
                    Text("\u{1F525} \(habit.currentStreak) dagar i rad")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            }

            Spacer()

            if habit.isCompletedToday {
                Text("Klar!")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }
}
