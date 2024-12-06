//
//  SelectLocationView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct SelectLocationView: View {
    @State private var searchText = ""
    @State private var cities = ["Dallas", "Houston", "Chicago", "New York", "Los Angeles", "San Francisco"]
    @State private var selectedCity = ""
    @State private var navigateToMainView = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(spacing: 20) {
            // Back Button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.green)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // Header
            VStack(spacing: 10) {
                Text("Select Your Location")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                Text("Find events in your city or search for other locations.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            // Search Bar
            TextField("Search for your city (e.g., Dallas)", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            // City List
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(filteredCities(), id: \.self) { city in
                        Button(action: {
                            selectedCity = city
                            saveSelectedCity()
                            navigateToMainView = true
                        }) {
                            Text(city)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(radius: 2)
                        }
                    }
                    
                    if !cities.contains(searchText) && !searchText.isEmpty {
                        Button(action: {
                            selectedCity = searchText
                            saveSelectedCity()
                            navigateToMainView = true
                        }) {
                            Text("Add \"\(searchText)\"")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(radius: 2)
                        }
                    }
                }
                .padding()
            }
            
            // GPS Integration
            if let detectedCity = locationManager.city {
                Text("Detected location: \(detectedCity)")
                Button(action: {
                    selectedCity = detectedCity
                    saveSelectedCity()
                    navigateToMainView = true
                }) {
                    Text("Use Current Location")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            } else {
                Button(action: {
                    locationManager.requestLocation()
                }) {
                    Text("Detect My Location")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
            
            // Hidden NavigationLink
            NavigationLink(
                destination: MainView(selectedCity: selectedCity),
                isActive: $navigateToMainView,
                label: {
                    EmptyView()
                }
            )
            .hidden()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
    func filteredCities() -> [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func saveSelectedCity() {
        UserDefaults.standard.set(selectedCity, forKey: "UserCity")
    }
}

struct SelectLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationView()
    }
}
