//
//  EventDetailsView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI
import MapKit

struct EventDetailsView: View {
    var event: Event
    @State private var isRegistered = false
    @State private var showConfirmation = false
    @State private var showShareSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Event Image
                Image(event.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()

                // Event Details
                VStack(alignment: .leading, spacing: 15) {
                    Text(event.name)
                        .font(.system(size: 28, weight: .bold))

                    // Date and Time
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.green)
                        Text("\(formatDate(event.date)) at \(event.time)")
                    }
                    .font(.headline)

                    // Location
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Text("\(event.address), \(event.city)")
                    }
                    .font(.headline)

                    // Buttons
                    HStack(spacing: 15) {
                        Button(action: {
                            openInMaps()
                        }) {
                            Text("Get Directions")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }

                        Button(action: {
                            registerForEvent()
                        }) {
                            Text(isRegistered ? "Registered" : "Register")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isRegistered ? Color.gray : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(25)
                        }
                    }

                    // Description
                    Text(event.description)
                        .font(.body)
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }
        )
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Success"), message: Text("You've successfully registered for this event!"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [shareText])
        }
    }

    var shareText: String {
        """
        Check out this event: \(event.name)
        When: \(formatDate(event.date)) at \(event.time)
        Where: \(event.address), \(event.city)
        """
    }

    func registerForEvent() {
        // For testing purposes, we'll simulate registration
        isRegistered = true
        showConfirmation = true
    }

    func openInMaps() {
        let address = "\(event.address), \(event.city)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first {
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = event.name
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            }
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: sampleEvent)
    }
}
