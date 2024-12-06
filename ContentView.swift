//
//  ContentView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WelcomeView()
                .navigationBarHidden(true)
        }
        .accentColor(.green) // Set global accent color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

