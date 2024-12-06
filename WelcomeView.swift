//
//  WelcomeView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Logo
            Image(systemName: "moon.stars.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding(.bottom, 10)
            
            // Welcome Text
            VStack(spacing: 10) {
                Text("Assalamu Alaikum! Welcome to Halaqat.")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                Text("Discover Islamic events in your area and stay connected to your community.")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 15) {
                NavigationLink(destination: SignInView()) {
                    Text("Log In to Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                
                NavigationLink(destination: SignUpView()) {
                    Text("New here? Create an Account")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
