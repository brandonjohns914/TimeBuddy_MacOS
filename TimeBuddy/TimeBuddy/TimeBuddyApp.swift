//
//  TimeBuddyApp.swift
//  TimeBuddy
//
//  Created by Brandon Johns on 1/8/24.
//

import SwiftUI

@main
struct TimeBuddyApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            Label("Time Buddy", systemImage: "person.badge.clock.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
