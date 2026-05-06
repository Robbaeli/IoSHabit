//
//  IoSHabitApp.swift
//  IoSHabit
//
//  Created by Robin Eliasson on 2026-05-02.
//

import SwiftUI
import SwiftData

@main
struct IoSHabitApp: App {
    @State private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await notificationManager.requestAuthorization()
                }
                .environment(notificationManager)
        }
        .modelContainer(for: Habit.self)
    }
}
