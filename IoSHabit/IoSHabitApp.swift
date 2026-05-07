//
//  IoSHabitApp.swift
//  IoSHabit
//
//  Created by Robin Eliasson on 2026-05-02.
//

import SwiftUI
import SwiftData

// Appens startpunkt
@main
struct IoSHabitApp: App {
    @State private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Ber om notis-tillstånd när appen startar
                .task {
                    await notificationManager.requestAuthorization()
                }
                // Gör notificationManager tillgänglig i alla vyer
                .environment(notificationManager)
        }
        // Sätter upp databasen för Habit-modellen
        .modelContainer(for: Habit.self)
    }
}
