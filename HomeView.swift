//
//  HomeView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct HomeView: View {
    var city: String
    @State private var events: [Event] = []
    @State private var showAddEventView = false
    @State private var selectedCategories: [String] = []
    @State private var sortOption = "Date"
    private let categories = ["Halaqa", "Fundraiser", "Sports", "Education"]
    private let sortOptions = ["Date", "Relevance", "Popularity"]

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Spacer()
                    Text("Events in \(city)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "location.fill")
                        .foregroundColor(.green)
                    Spacer()
                }
                .padding()

                // Category Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                if selectedCategories.contains(category) {
                                    selectedCategories.removeAll { $0 == category }
                                } else {
                                    selectedCategories.append(category)
                                }
                                loadEvents()
                            }) {
                                Text(category)
                                    .padding()
                                    .background(selectedCategories.contains(category) ? Color.green : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Sort Options
                Picker("Sort by", selection: $sortOption) {
                    ForEach(sortOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: sortOption, perform: { _ in
                    loadEvents()
                })

                // Event List
                if events.isEmpty {
                    Spacer()
                    Text("No events found in \(city). Try adding one!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(events) { event in
                                NavigationLink(destination: EventDetailsView(event: event)) {
                                    EventCard(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showAddEventView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddEventView) {
                AddEventView()
            }
            .onAppear {
                loadEvents()
            }
        }
    }

    func loadEvents() {
        // Use the global sampleEvents array
        var allEvents = sampleEvents.filter { $0.city == city }

        // Apply category filters
        if !selectedCategories.isEmpty {
            allEvents = allEvents.filter { selectedCategories.contains($0.type) }
        }

        // Sort events
        switch sortOption {
        case "Date":
            allEvents.sort { $0.date < $1.date }
        case "Popularity":
            allEvents.sort { $0.registeredUsersCount > $1.registeredUsersCount }
        default:
            break
        }

        events = allEvents
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(city: "Dallas")
    }
}
