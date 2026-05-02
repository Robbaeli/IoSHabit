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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Habit.self)
    }
}
