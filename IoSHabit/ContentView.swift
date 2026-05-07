//
//  ContentView.swift
//  IoSHabit
//
//  Created by Robin Eliasson on 2026-05-02.
//

import SwiftUI
import SwiftData

// Appens huvudvy som visar HabitListView
struct ContentView: View {
    var body: some View {
        HabitListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
