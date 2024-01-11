//
//  ContentView.swift
//  TimeBuddy
//
//  Created by Brandon Johns on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeZones = [String]()
    @State private var newTimeZone = "GMT"
    @State private var selectedTimeZones = Set<String>()
    var body: some View {
        VStack {
            if timeZones.isEmpty {
                Text("Please add your first time zone below")
                    .frame(maxHeight: .infinity)
            } else {
                List(selection: $selectedTimeZones) {
                    ForEach(timeZones, id: \.self) { timeZone in
                        let time = timeData(for: timeZone)
                        Text(time)
                    }
                    .onMove(perform: moveItems)
                }
                .onDeleteCommand(perform: deleteItems)
            }
            
            HStack {
                Picker("Add Time Zone", selection: $newTimeZone) {
                    ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self){ timeZone in
                            Text(timeZone)
                    }
                }
                Button("Add") {
                    if timeZones.contains(newTimeZone) == false {
                        timeZones.append(newTimeZone)
                        save()
                    }
                }
            }
            
        }
        .padding()
        .onAppear(perform: load)
    }
    
    func timeData(for zoneName: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = TimeZone(identifier: zoneName) ?? .current
        return "\(zoneName): \(dateFormatter.string(from: .now))"
    }
    
    func load() {
        timeZones = UserDefaults.standard.stringArray(forKey: "TimeZones") ?? []
    }
    
    func save() {
        UserDefaults.standard.set(timeZones, forKey: "TimeZones")
    }
    
    func deleteItems() {
        withAnimation {
            timeZones.removeAll(where: selectedTimeZones.contains)
        }
        save()
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        timeZones.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    func quit() {
        NSApp.terminate(nil)
    }
}

#Preview {
    ContentView()
}
