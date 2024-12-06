//
//  AddEventView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var date = Date()
    @State private var time = ""
    @State private var type = ""
    @State private var description = ""
    @State private var city = UserDefaults.standard.string(forKey: "UserCity") ?? "Dallas"
    @State private var address = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $name)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Time (e.g., 5:00 PM)", text: $time)
                    TextField("Type (e.g., Fundraiser)", text: $type)
                    TextField("City", text: $city)
                    TextField("Address", text: $address)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("Add New Event", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                saveEvent()
            })
        }
    }

    func saveEvent() {
        if name.isEmpty || time.isEmpty || type.isEmpty || description.isEmpty || city.isEmpty || address.isEmpty {
            errorMessage = "Please fill in all fields."
            return
        }

        let newEvent = Event(
            name: name,
            date: date,
            time: time,
            type: type,
            description: description,
            imageName: "event_placeholder",
            city: city,
            address: address
        )

        // Append the new event to the global sampleEvents array
        sampleEvents.append(newEvent)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}

