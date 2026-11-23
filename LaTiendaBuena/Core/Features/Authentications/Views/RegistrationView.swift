//
//  RegistrationView.swift
//  LaTiendaBuena
//
//  Created by Arhan on 25/08/26.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var passwordMatch = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.supabase)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 8) {
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    TextField("Enter your username", text: $username)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    ZStack(alignment: .trailing) {
                        SecureField("Enter password", text: $password)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            
                        if !password.isEmpty && !confirmedPassword.isEmpty {
                            Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(passwordMatch ? .green : .red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    ZStack(alignment: .trailing) {
                        SecureField("Confirmed password", text: $confirmedPassword)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            
                        if !password.isEmpty && !confirmedPassword.isEmpty {
                            Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(passwordMatch ? .green : .red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal, 24)
                    .onChange(of: confirmedPassword) {
                        oldValue, newValue in
                        passwordMatch = newValue == password
                    }
                    
                    
                }
                
                Button { signUp() } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(width: 360, height: 48)
                        .background(.blue)
                        .cornerRadius(8)
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                Divider()
                
                Button { dismiss() } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

private extension RegistrationView {
    func signUp() {
        Task {
            isLoading = true
            await authManager.signUp(
                email: email,
                password: password,
                username: username)
            isLoading = false
        }
    }
    
    var formIsValid: Bool {
        return email.isValidEmail() && passwordMatch && username.count > 1
    }
}

#Preview {
    RegistrationView()
}
