//
//  UserProfileView.swift
//  LaTiendaBuena
//
//  Created by Arhan on 25/10/26.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                if let currentUser = userManager.currentUser {
                    Section {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 72, height: 72)
                                .foregroundStyle(.secondary)
                            
                            VStack(alignment: .leading) {
                                Text(currentUser.username)
                                
                                Text(currentUser.email).foregroundStyle(.secondary)
                            }
                            .font(.subheadline)
                        }
                    }
                    Section("Account") {
                        Button("Sign Out") {
                            Task { await authManager.signOut() }
                        }
                    }
                } else if userManager.isLoading {
                    Section {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                } else {
                    // User authenticated but no profile found
                    Section {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.orange)
                            
                            Text("Profile Not Found")
                                .font(.headline)
                            
                            Text("Your account exists, but your profile wasn't created properly. Please sign out and sign up again.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                            
                            Button("Sign Out") {
                                Task { await authManager.signOut() }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    UserProfileView()
}
