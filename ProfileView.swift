//
//  ProfileView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var primaryCity = UserDefaults.standard.string(forKey: "UserCity") ?? "Dallas"
    @State private var syncCalendar = false
    @State private var showLogoutConfirmation = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Header
                VStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.green)
                    Text("Test User")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                
                // Settings List
                Form {
                    Section(header: Text("Settings")) {
                        // Primary City
                        HStack {
                            Text("Primary City")
                            Spacer()
                            Text(primaryCity)
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Handle city selection
                        }
                        
                        // Sync with Calendar
                        Toggle(isOn: $syncCalendar) {
                            VStack(alignment: .leading) {
                                Text("Sync with Calendar")
                                Text("Automatically add events to your calendar.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Logout
                    Button(action: {
                        showLogoutConfirmation = true
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                    .alert(isPresented: $showLogoutConfirmation) {
                        Alert(
                            title: Text("Are you sure you want to logout?"),
                            primaryButton: .destructive(Text("Logout")) {
                                logout()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }

    func logout() {
        // For testing, we'll navigate back to the WelcomeView
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
