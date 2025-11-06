//
//  FindewApp.swift
//  Findew
//
//  Created by Apple Coding machine on 10/21/25.
//

import SwiftUI

@main
struct FindewApp: App {
    @State var appFlow: AppFlow = .init()
    @State var container: DIContainer = .init()
    
    var body: some Scene {
        WindowGroup {
            switch appFlow.appState {
            case .splash:
                Splash()
            case .login:
                LoginView(container: container)
            case .home:
                Text("1")
            }
        }
        .environment(\.appFlow, appFlow)
        .environment(\.container, container)
    }
}
