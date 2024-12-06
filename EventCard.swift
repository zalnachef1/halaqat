//
//  EventCard.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct EventCard: View {
    var event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Event Image
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)

            // Event Details
            VStack(alignment: .leading, spacing: 5) {
                Text(event.type)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 5)
                    .background(Color.green)
                    .cornerRadius(5)
                Text(event.name)
                    .font(.headline)
                HStack {
                    Text(formatDate(event.date))
                    Text("at")
                    Text(event.time)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: sampleEvent)
    }
}
