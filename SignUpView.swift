//
//  SignUpView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showSelectLocationView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                // Header
                VStack(spacing: 10) {
                    Text("Create Your Halaqat Account")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    Text("Start exploring events near you today.")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                // Form Fields
                VStack(spacing: 15) {
                    TextField("Enter your full name (e.g., Aisha Khan)", text: $fullName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("Enter your email address", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Confirm your password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Sign Up Button
                Button(action: {
                    signUp()
                }) {
                    Text("Create Account")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                // Back to Login
                Button(action: {
                    // Navigate back to WelcomeView
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back to Login")
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)
                
                Spacer()
                
                // Hidden NavigationLink
                NavigationLink(
                    destination: SelectLocationView(),
                    isActive: $showSelectLocationView,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func signUp() {
        // Input validation
        if fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill in all fields."
            return
        }
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email."
            return
        }
        
        // Simulate account creation delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // For testing purposes, assume sign-up is always successful
            showSelectLocationView = true
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
