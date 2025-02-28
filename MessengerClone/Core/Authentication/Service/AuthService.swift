//
//  AuthService.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

/// A service that manages user authentication with Firebase.
///
/// This class handles all authentication-related operations including user login,
/// registration, and sign out. It maintains the current authentication state and
/// publishes changes to the user session.
///
/// ## Overview
///
/// `AuthService` is implemented as a singleton to ensure consistent authentication
/// state throughout the application. It interfaces with Firebase Authentication for
/// user management and Firestore for storing additional user information.
///
/// ## Example Usage
///
/// ```swift
/// // Login a user
/// Task {
///     do {
///         try await AuthService.shared.login(withEmail: "user@example.com", password: "password123")
///         // User is now logged in
///     } catch {
///         // Handle login error
///     }
/// }
///
/// // Check if a user is logged in
/// if let user = AuthService.shared.userSession {
///     print("User is logged in with ID: \(user.uid)")
/// } else {
///     print("No user is currently logged in")
/// }
/// ```
class AuthService {
	
	/// The current authenticated user session.
	///
	/// This property publishes changes to the authentication state, allowing views
	/// to reactively update when a user logs in or out. When `nil`, no user is logged in.
	@Published var userSession: FirebaseAuth.User?
	
	/// The shared singleton instance of the authentication service.
	///
	/// Use this property to access authentication functionality throughout the app.
	static let shared = AuthService()
	
	/// Initializes the authentication service.
	///
	/// This initializer retrieves the current user session from Firebase Authentication
	/// if a user was previously logged in and their session is still valid.
	init() {
		self.userSession = Auth.auth().currentUser
		loadCurrentUserData()
		print("DEBUG: USER SESSION ID IS \(String(describing: userSession?.uid))")
	}
	
	/// Authenticates a user with email and password.
	///
	/// This method attempts to sign in a user with the provided credentials using Firebase Authentication.
	/// If successful, it updates the `userSession` property with the authenticated user.
	///
	/// - Parameters:
	///   - email: The user's email address
	///   - password: The user's password
	///
	/// - Throws: An error if the authentication fails
	@MainActor
	func login(withEmail email: String, password: String) async throws {
		do {
			let result = try await Auth.auth().signIn(withEmail: email, password: password)
			self.userSession = result.user
			loadCurrentUserData()
		} catch {
			print("DEBUG: FAILED TO LOG USER IN WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	/// Creates a new user account with the provided information.
	///
	/// This method registers a new user with Firebase Authentication using the provided email and password.
	/// If successful, it automatically signs in the user, updates the `userSession` property, and stores
	/// the user's information in Firestore.
	///
	/// - Parameters:
	///   - email: The email address for the new account
	///   - password: The password for the new account
	///   - fullName: The user's full name
	///
	/// - Throws: An error if the account creation fails
	@MainActor
	func createUser(withEmail email: String, password: String, fullName: String) async throws {
		do {
			let result = try await Auth.auth().createUser(withEmail: email, password: password)
			self.userSession = result.user
			try await self.uploadUserData(email: email, fullName: fullName, id: result.user.uid)
			loadCurrentUserData()
		} catch {
			print("DEBUG: FAILED TO CREATE USER WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	/// Signs out the currently authenticated user.
	///
	/// This method signs out the current user from Firebase Authentication and
	/// sets the `userSession` property to `nil`.
	
	func signOut() {
		do {
			try Auth.auth().signOut()
			self.userSession = nil
			UserService.shared.currentUser = nil
		} catch {
			print("DEBUG: FAILED TO LOG USER OUT. \(error.localizedDescription)")
		}
	}
	
	/// Uploads user data to Firestore after successful registration.
	///
	/// This private method creates a user document in Firestore with the user's information
	/// after a successful account creation.
	///
	/// - Parameters:
	///   - email: The user's email address
	///   - fullName: The user's full name
	///   - id: The user's unique identifier from Firebase Authentication
	///
	/// - Throws: An error if the data upload fails
	
	private func uploadUserData(email: String, fullName: String, id: String) async throws {
		
		let user = User(
			fullName: fullName,
			email: email,
			profileImageURL: nil
		)
		
		guard let encodedUser = try? Firestore.Encoder().encode(user) else {
			return
		}
		
		try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
	}
	
	private func loadCurrentUserData() {
		Task { try await UserService.shared.fetchCurrentUser() }
	}
}



