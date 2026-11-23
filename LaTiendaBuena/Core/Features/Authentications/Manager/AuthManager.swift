//
//  AuthManager.swift
//  LaTiendaBuena
//
//  Created by Arhan on 29/08/26.
//

import Foundation

@Observable
final class AuthManager {
    var authState: AuthState = .unknown
    var currentUserId: String?
    
    private let authService: SupabaseAuthService
    
    init(authService: SupabaseAuthService = SupabaseAuthService()) {
        self.authService = authService
    }
    
    func signIn(email: String, password: String) async {
        do {
            currentUserId = try await authService.signIn(email: email, password: password)
            authState = .authenticated
            print("DEBUG: Auth state \(authState)")
        } catch {
            print("Sign-in error: \(error)")
        }
    }
    
    func signUp(email: String, password: String, username: String) async {
        do {
            currentUserId = try await authService.signUp(email: email, password: password, username: username)
            authState = .authenticated
        } catch {
            print("Sign up error: \(error)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            currentUserId = nil
            authState = .unauthenticated
        } catch {
            print("Sign out error: \(error)")
        }
    }
    
    func refreshUser() async {
        do {
            let userSessionId = try await authService.getCurrentUserSession()
            if let userSessionId {
                self.authState = .authenticated
                self.currentUserId = userSessionId
            }
        } catch {
            print("Refresh user error: \(error)")
            currentUserId = nil
            authState = .unauthenticated
        }
    }
}
