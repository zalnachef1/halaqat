//
//  Models.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

// Models.swift
import Foundation

struct Event: Identifiable {
    var id: UUID = UUID()
    var name: String
    var date: Date
    var time: String
    var type: String
    var description: String
    var imageName: String
    var city: String
    var address: String
    var registeredUsersCount: Int = 0
}

// Sample Events Data
var sampleEvents: [Event] = [
    Event(
        name: "Community Fundraiser",
        date: Date(),
        time: "5:00 PM",
        type: "Fundraiser",
        description: "Join us for a community fundraiser.",
        imageName: "event1",
        city: "Dallas",
        address: "123 Main Street",
        registeredUsersCount: 25
    ),
    Event(
        name: "Weekly Halaqa",
        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        time: "7:00 PM",
        type: "Halaqa",
        description: "Weekly gathering for spiritual discussions.",
        imageName: "event2",
        city: "Dallas",
        address: "456 Elm Street",
        registeredUsersCount: 40
    ),
    // Add more sample events as needed
]

let sampleEvent = sampleEvents[0]
