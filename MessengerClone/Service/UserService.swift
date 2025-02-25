//
//  UserService.swift
//  MessengerClone
//
//  Created by Justin Hold on 2/25/25.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

/// A service class responsible for managing user data.
///
/// This class provides functionality to fetch and maintain information about the currently
/// authenticated user from Firestore.
///
/// ## Overview
///
/// `UserService` is implemented as a singleton to ensure consistent user data throughout
/// the application. It works in conjunction with Firebase Authentication and Firestore
/// to retrieve the current user's profile information.
///
/// ## Example Usage
///
/// ```swift
/// // Fetch the current user's profile
/// Task {
///     do {
///         try await UserService.shared.fetchCurrentUser()
///         if let user = UserService.shared.currentUser {
///             print("Current user: \(user.fullName)")
///         }
///     } catch {
///         print("Failed to fetch user: \(error)")
///     }
/// }
/// ```
class UserService {
	
	/// The current user's profile information.
	///
	/// This published property updates when the user's profile is fetched or changed.
	/// SwiftUI views observing this property will be updated automatically when it changes.
	/// When `nil`, either no user is logged in or the user data hasn't been fetched yet.
	@Published var currentUser: User?
	
	/// The shared singleton instance of the user service.
	///
	/// Use this property to access user data functionality throughout the app.
	static let shared = UserService()
	
	/// Fetches the current user's profile information from Firestore.
	///
	/// This method retrieves the user document from Firestore based on the current
	/// Firebase Authentication user ID. If successful, it updates the `currentUser`
	/// property with the fetched user data.
	///
	/// - Throws: An error if fetching the user data fails or if no user is currently authenticated.
	func fetchCurrentUser() async throws {
		
		guard let uid = Auth.auth().currentUser?.uid else {
			return
		}
		
		let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
		let user = try snapshot.data(as: User.self)
		
		self.currentUser = user
		print("DEBUG: The currently logged in user is \(currentUser ?? User.mockUser)")
	}
}
