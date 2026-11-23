//
//  UserManager.swift
//  LaTiendaBuena
//
//  Created by Arhan on 04/10/26.
//

import Foundation
import Supabase

@Observable
final class UserManager {
    var currentUser: User?
    var isLoading = false
    
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
    }
    
    func fetchCurrentUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.currentUser = try await service.fetchCurrentUser()
            print("DEBUG: Current user \(currentUser)")
        } catch let error as PostgrestError where error.code == "PGRST116" {
            print("DEBUG: User not found in database (0 rows). This user may need to sign up again or their profile wasn't created.")
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to fetch current user: \(error)")
            self.currentUser = nil
        }
    }
}
