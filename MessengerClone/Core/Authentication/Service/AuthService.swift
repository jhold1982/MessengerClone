//
//  AuthService.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

/**
 A service class that manages authentication operations for the application.
 
 `AuthService` provides a centralized way to handle user authentication flows including
 login, account creation, and sign out. It uses Firebase Authentication for identity management
 and exposes the current authentication state through a published property.
 
 ## Features
 - Singleton pattern for app-wide access (`shared`)
 - Manages current user session state
 - Handles user authentication (login, registration, sign out)
 - Integrates with Firebase Authentication
 
 ## Example
 ```swift
 // Log in a user
 try await AuthService.shared.login(withEmail: "user@example.com", password: "password123")
 
 // Sign out the current user
 AuthService.shared.signOut()
 
 // Check if a user is logged in
 if AuthService.shared.userSession != nil {
	 // User is authenticated
 }
 ```
 */
class AuthService {
	
	/**
	 The current authenticated user session.
	 
	 This property publishes changes to the authentication state, allowing views
	 to reactively update when a user logs in or out. When `nil`, no user is logged in.
	 */
	@Published var userSession: FirebaseAuth.User?
	
	/**
	 The shared singleton instance of the authentication service.
	 
	 Use this property to access authentication functionality throughout the app.
	 */
	static let shared = AuthService()
	
	/**
	 Initializes the authentication service.
	 
	 This initializer retrieves the current user session from Firebase Authentication
	 if a user was previously logged in and their session is still valid.
	 */
	init() {
		self.userSession = Auth.auth().currentUser
		print("DEBUG: USER SESSION ID IS \(String(describing: userSession?.uid))")
	}
	
	/**
	 Authenticates a user with email and password.
	 
	 This method attempts to sign in a user with the provided credentials using Firebase Authentication.
	 If successful, it updates the `userSession` property with the authenticated user.
	 
	 - Parameters:
		- email: The user's email address
		- password: The user's password
	 
	 - Throws: An error if the authentication fails
	 */
	func login(withEmail email: String, password: String) async throws {
		do {
			let result = try await Auth.auth().signIn(withEmail: email, password: password)
			self.userSession = result.user
		} catch {
			print("DEBUG: FAILED TO LOG USER IN WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	/**
	 Creates a new user account with the provided information.
	 
	 This method registers a new user with Firebase Authentication using the provided email and password.
	 If successful, it automatically signs in the user and updates the `userSession` property.
	 
	 - Parameters:
		- email: The email address for the new account
		- password: The password for the new account
		- fullName: The user's full name
	 
	 - Throws: An error if the account creation fails
	 
	 - Note: Currently, the `fullName` parameter is collected but not used in the account creation.
	   This would typically be stored in Firestore alongside the user record.
	 */
	func createUser(withEmail email: String, password: String, fullName: String) async throws {
		do {
			let result = try await Auth.auth().createUser(withEmail: email, password: password)
			self.userSession = result.user
		} catch {
			print("DEBUG: FAILED TO CREATE USER WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	/**
	 Signs out the currently authenticated user.
	 
	 This method signs out the current user from Firebase Authentication and
	 sets the `userSession` property to `nil`.
	 */
	func signOut() {
		do {
			try Auth.auth().signOut()
			self.userSession = nil
		} catch {
			print("DEBUG: FAILED TO LOG USER OUT. \(error.localizedDescription)")
		}
	}
}




