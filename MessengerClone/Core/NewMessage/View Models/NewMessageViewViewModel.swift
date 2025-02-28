//
//  NewMessageViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 2/28/25.
//

import Foundation
import Firebase

/// A view model that manages the state and data for the new message view.
///
/// The `NewMessageViewViewModel` class conforms to the `ObservableObject` protocol,
/// which allows SwiftUI views to observe and react to changes in the view model's
/// published properties. This view model is responsible for fetching and maintaining
/// a list of users that can be recipients of new messages.
/// A view model responsible for managing and providing a list of users for new message creation.
///
/// `NewMessageViewViewModel` fetches user data asynchronously and ensures that UI updates occur
/// on the main thread. It excludes the currently authenticated user from the list of recipients.
class NewMessageViewViewModel: ObservableObject {
	
	/// An array of `User` objects representing potential message recipients.
	@Published var users = [User]()
	
	/// Initializes the view model and triggers the asynchronous fetching of users.
	///
	/// The `fetchUsers()` method is executed within a `Task` to ensure it runs asynchronously.
	init() {
		Task {
			try await fetchUsers()
		}
	}
	
	/// Asynchronously fetches all users from the `UserService`, excluding the currently authenticated user.
	///
	/// - Important: This method is marked with `@MainActor` to ensure UI updates occur on the main thread.
	/// - Throws: An error if the user fetching process fails.
	@MainActor
	func fetchUsers() async throws {
		/// Ensures that the currently authenticated user's ID is available before proceeding.
		guard let currentUID = Auth.auth().currentUser?.uid else { return }
		
		/// Retrieves all users and filters out the currently authenticated user.
		let users = try await UserService.fetchAllUsers()
		self.users = users.filter { $0.id != currentUID }
	}
}

