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

/**
 A service class that manages user data and operations.
 
 `UserService` provides functionality for accessing and managing user data
 throughout the application. It includes methods for fetching the current user's
 profile information and retrieving all users from the Firestore database.
 */
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
	
	/**
	 Fetches the current user's profile information from Firestore.
	 
	 This method retrieves the user document from Firestore based on the current
	 Firebase Authentication user ID. If successful, it updates the `currentUser`
	 property with the fetched user data.
	 
	 - Throws: `FirestoreError` if there's an issue connecting to Firestore or retrieving the document.
			  May also throw deserialization errors if the document structure is unexpected.
			  No error is thrown if no user is currently authenticated.
	 
	 - Note: This method silently returns without error if no user is authenticated.
			Check `Auth.auth().currentUser` before calling if authentication state is uncertain.
	 
	 ### Example
	 ```
	 do {
		 try await UserService.shared.fetchCurrentUser()
		 if let user = UserService.shared.currentUser {
			 print("Fetched user: \(user.username)")
		 }
	 } catch {
		 print("Failed to fetch current user: \(error)")
	 }
	 ```
	 */
	func fetchCurrentUser() async throws {
		
		guard let uid = Auth.auth().currentUser?.uid else {
			return
		}
		
		let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
		let user = try snapshot.data(as: User.self)
		
		self.currentUser = user
		print("DEBUG: The currently logged in user is \(currentUser ?? User.mockUser)")
	}
	
	/**
	 * Fetches all users from Firestore with an optional limit.
	 *
	 * This static method retrieves user documents from the Firestore users collection
	 * and converts them to User objects. It supports limiting the number of results returned.
	 *
	 * - Parameter limit: Optional parameter to limit the number of users fetched.
	 *                   If nil, all users will be fetched.
	 *
	 * - Returns: An array of User objects.
	 *
	 * - Throws: FirestoreError if there's an issue with the Firestore query,
	 *           or any decoding errors when converting documents to User objects.
	 */
	static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
		// Create a query reference from the user collection
		let query = FirestoreConstants.userCollection
		
		// Apply limit if provided
		if let limit {
			query.limit(to: limit)
		}
		
		// Execute the query and get documents
		let snapshot = try await query.getDocuments()
		
		// Transform the snapshot documents into User objects
		return snapshot.documents.compactMap { try? $0.data(as: User.self) }
	}

	/**
	 * Fetches a single user by their unique identifier.
	 *
	 * This static method retrieves a specific user document from Firestore based on
	 * the provided user ID and returns it via a completion handler.
	 *
	 * - Parameters:
	 *   - withUID: The unique identifier of the user to fetch.
	 *   - completion: A closure that will be called with the User object when the fetch completes.
	 *                 This closure will not be called if the document doesn't exist or
	 *                 cannot be decoded as a User.
	 *
	 * - Note: This method uses a completion handler pattern instead of async/await.
	 *         It silently fails if the user cannot be found or decoded.
	 */
	static func fetchUser(withUID uid: String, completion: @escaping(User) -> Void) {
		FirestoreConstants.userCollection.document(uid).getDocument { snapshot, _ in
			guard let user = try? snapshot?.data(as: User.self) else { return }
			completion(user)
		}
	}
}
