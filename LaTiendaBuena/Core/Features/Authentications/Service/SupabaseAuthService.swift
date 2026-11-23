//
//  SupabaseAuthService.swift
//  LaTiendaBuena
//
//  Created by Arhan on 29/08/26.
//

import Foundation
import Supabase

struct SupabaseAuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey)
    }
    
    func signIn(email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    func signUp(email: String, password: String, username: String) async throws -> String {
        let response = try await client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        // upload user data here..
        try await uploadUserData(with: userId, email: email, username: username)
        return userId
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUserSession() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
    
    private func uploadUserData(with uid: String, email: String, username: String) async throws {
        let user = User(
            id: uid,
            email: email,
            username: username,
            createdAt: Date(),
            totalSales: 0,
            itemsSold: 0,
            itemsPurchased: 0
        )
        
        // Add custom encoder for date formatting
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let response = try await client.from("users")
                .insert(user, returning: .representation)
                .execute()
            print("DEBUG: User data uploaded successfully: \(response)")
        } catch {
            print("DEBUG: Failed to upload user data: \(error)")
            throw error
        }
    }
}
