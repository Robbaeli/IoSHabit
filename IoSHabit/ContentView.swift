//
//  ContentView.swift
//  IoSHabit
//
//  Created by Robin Eliasson on 2026-05-02.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        HabitListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Habit.self, inMemory: true)
}
