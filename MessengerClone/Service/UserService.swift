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
	 Fetches all users from the Firestore database.
	 
	 This function retrieves all user documents from the "users" collection in Firestore
	 and converts them to local `User` model objects. Documents that cannot be decoded
	 into `User` objects will be silently skipped.
	 
	 - Returns: An array of `User` objects representing all valid user documents in the database.
	 
	 - Throws: `FirestoreError` if there's an issue connecting to Firestore or retrieving documents.
			  May also throw deserialization errors if the document structure is unexpected.
	 
	 - Warning: This operation performs a full collection read, which may have performance and
			   billing implications for large collections. Consider pagination for production use.
	 
	 ### Example
	 ```
	 do {
		 let allUsers = try await UserService.fetchAllUsers()
		 print("Fetched \(allUsers.count) users")
	 } catch {
		 print("Failed to fetch users: \(error)")
	 }
	 ```
	 */
	static func fetchAllUsers() async throws -> [User] {
		let snapshot = try await Firestore.firestore().collection("users").getDocuments()
		return snapshot.documents.compactMap { try? $0.data(as: User.self) }
	}
}
