//
//  ContentView.swift
//  LaTiendaBuena
//
//  Created by Arhan on 25/08/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                Text("Main interface..")
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task {
            await authManager.refreshUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
