//
//  HalaqatApp.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

@main
struct HalaqatApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

