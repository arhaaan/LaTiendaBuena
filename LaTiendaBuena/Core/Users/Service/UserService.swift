//
//  UserService.swift
//  LaTiendaBuena
//
//  Created by Arhan on 04/10/26.
//

import Foundation
import Supabase

struct UserService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func fetchCurrentUser() async throws -> User {
        let supabaseUser = try await client.auth.session.user
        
        // Add custom decoder for date formatting
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try await client.from("users")
            .select()
            .eq("id", value: supabaseUser.id.uuidString)
            .single()
            .execute()
            .value
    }
}
