//
//  MessengerCloneApp.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import Foundation
import SwiftUI
import FirebaseCore

/**
 Firebase configuration delegate for the application.
 
 The `AppDelegate` class is responsible for configuring Firebase services during
 application launch. It implements the `UIApplicationDelegate` protocol to hook into
 the application lifecycle events.
 
 ## Responsibilities
 - Initializes Firebase services at application launch
 - Ensures Firebase is properly configured before any Firebase-dependent features are used
 
 ## Usage
 This class is automatically instantiated and registered with the application
 via the `@UIApplicationDelegateAdaptor` property wrapper in the `MessengerCloneApp` struct.
 */
class AppDelegate: NSObject, UIApplicationDelegate {
  /**
   Configures Firebase when the application finishes launching.
   
   This method is called automatically by the UIKit application lifecycle,
   and is responsible for initializing Firebase services.
   
   - Parameters:
	 - application: The singleton app object
	 - launchOptions: A dictionary indicating the reason the app was launched (if any)
   
   - Returns: `true` to indicate successful initialization
   */
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
	) -> Bool {
	FirebaseApp.configure()
	
	return true
  }
}

/**
 The main entry point of the Messenger Clone application.
 
 `MessengerCloneApp` is the root structure of the SwiftUI application. It's annotated with
 the `@main` attribute, indicating to Swift that this is the application's entry point.
 It sets up the Firebase configuration through an AppDelegate and defines the initial
 view hierarchy with `ContentView` as the root view.
 
 ## Features
 - Configures Firebase using the UIApplicationDelegateAdaptor pattern
 - Sets up the main window and initial view hierarchy
 - Serves as the application's entry point
 
 ## Dependencies
 - Requires Firebase Core to be included in the project
 - Uses ContentView as the root view
 
 ## Example
 The `@main` attribute makes this struct the automatic entry point;
 it doesn't need to be explicitly instantiated.
 */
@main
struct MessengerCloneApp: App {
	
	/**
	 Registers an AppDelegate instance to configure Firebase.
	 
	 This property uses the `@UIApplicationDelegateAdaptor` property wrapper to
	 bridge between SwiftUI's application lifecycle and UIKit's delegate pattern.
	 It ensures that Firebase is properly configured when the app launches.
	 */
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
	/**
	 Defines the root scene of the application.
	 
	 This property sets up the main window group and attaches the `ContentView`
	 as the root view of the application.
	 */
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
