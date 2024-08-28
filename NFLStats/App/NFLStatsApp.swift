//
//  NFLStatsApp.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 20/08/2024.
//

import SwiftUI
import Firebase

@main
struct NFLStatsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            SignInView()
            TeamListView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured FireBase.")

    return true
  }
}
