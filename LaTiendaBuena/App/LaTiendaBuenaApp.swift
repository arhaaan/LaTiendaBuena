//
//  LaTiendaBuenaApp.swift
//  LaTiendaBuena
//
//  Created by Arhan on 25/08/26.
//

import SwiftUI

@main
struct LaTiendaBuenaApp: App {
    @State private var authManager = AuthManager()
    @State private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
                .environment(userManager)
        }
    }
}
