//
//  ContentView.swift
//  LaTiendaBuena
//
//  Created by Arhan on 25/08/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                UserProfileView()
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task { await authManager.refreshUser() }
        .task(id: authManager.authState) {
            guard authManager.authState == .authenticated else { return }
            await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
