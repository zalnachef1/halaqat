//
//  SignInView.swift
//  Halaqat
//
//  Created by zayd on 11/29/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var isLoading = false
    @State private var showSelectLocationView = false
    @State private var emailError = ""
    @State private var passwordError = ""
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                // Header
                VStack(spacing: 10) {
                    Text("Welcome Back to Halaqat!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    Text("Log in to find nearby Islamic events and more.")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                // Form Inputs
                VStack(spacing: 15) {
                    TextField("Enter your email (e.g., you@example.com)", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: email) { _ in
                            validateEmail()
                        }
                    
                    if !emailError.isEmpty {
                        Text(emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .onChange(of: password) { _ in
                            validatePassword()
                        }
                    
                    if !passwordError.isEmpty {
                        Text(passwordError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    
                    Toggle(isOn: $rememberMe) {
                        Text("Remember Me")
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                // Sign In Button
                Button(action: {
                    signIn()
                }) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Text("Log In")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .disabled(isLoading)
                .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
                // Forgot Password
                Button(action: {
                    // Handle forgot password action
                }) {
                    Text("Forgot Password?")
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
    
    func validateEmail() {
        if isValidEmail(email) {
            emailError = ""
        } else {
            emailError = "Invalid email format."
        }
    }
    
    func validatePassword() {
        if password.isEmpty {
            passwordError = "Password cannot be empty."
        } else {
            passwordError = ""
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // Simple regex for email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func signIn() {
        isLoading = true
        errorMessage = ""
        
        // Validate inputs
        validateEmail()
        validatePassword()
        
        if !emailError.isEmpty || !passwordError.isEmpty {
            isLoading = false
            return
        }
        
        // Simulate authentication delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            // For testing purposes, assume login is successful if email and password are non-empty
            if email == "test@example.com" && password == "password" {
                showSelectLocationView = true
            } else {
                errorMessage = "Invalid email or password."
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
