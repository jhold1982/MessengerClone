//
//  MessengerCloneApp.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()

	return true
  }
}

@main
struct MessengerCloneApp: App {
	
	// register AppDelegate for Firebase setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
