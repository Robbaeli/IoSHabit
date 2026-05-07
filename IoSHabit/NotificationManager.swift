import Foundation
import UserNotifications

// Hanterar notiser: begär tillstånd, schemalägger och avbryter påminnelser
@Observable
final class NotificationManager {
    private(set) var isAuthorized = false

    // Ber användaren om lov att skicka notiser
    func requestAuthorization() async {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            isAuthorized = granted
        } catch {
            isAuthorized = false
        }
    }

    // Schemalägger en daglig notis som upprepas vid vald tid
    func scheduleDaily(for habit: Habit) {
        guard let reminderTime = habit.reminderTime else { return }

        let content = UNMutableNotificationContent()
        content.title = "Dags för din vana!"
        content.body = habit.name
        content.sound = .default

        let components = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(
            identifier: habit.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    // Tar bort schemalagd notis för en vana
    func cancel(for habit: Habit) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [habit.id.uuidString])
    }
}
