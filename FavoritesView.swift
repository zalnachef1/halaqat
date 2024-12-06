//
//  FavoritesView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favoriteEvents: [Event] = []

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Your Favorites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                // Favorites List
                if favoriteEvents.isEmpty {
                    Spacer()
                    Text("You haven't added any favorites yet.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(favoriteEvents) { event in
                            NavigationLink(destination: EventDetailsView(event: event)) {
                                HStack {
                                    Image(event.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipped()
                                        .cornerRadius(5)
                                    VStack(alignment: .leading) {
                                        Text(event.name)
                                            .font(.headline)
                                        Text("\(formatDate(event.date)) at \(event.time)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                loadFavoriteEvents()
            }
        }
    }

    func delete(at offsets: IndexSet) {
        favoriteEvents.remove(atOffsets: offsets)
    }

    func loadFavoriteEvents() {
        // For testing purposes, we'll use a subset of sample events
        favoriteEvents = Array(sampleEvents.prefix(1))
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
