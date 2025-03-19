//
//  ActiveNowViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/19/25.
//

import Foundation
import Firebase
import FirebaseAuth

/**
 * ActiveNowViewViewModel
 *
 * A view model that manages the state of users who are currently active.
 * Conforms to ObservableObject protocol to support SwiftUI data binding.
 */
class ActiveNowViewViewModel: ObservableObject {
	
	/// Published property that stores the array of User objects.
	/// When this property changes, it triggers UI updates in any observing views.
	@Published var users = [User]()
	
	/**
	 * Initializes a new instance of the view model.
	 * Immediately begins fetching all users asynchronously upon initialization.
	 */
	init() {
		Task { try await fetchAllUsers() }
	}
	
	/**
	 * Fetches all users from the UserService.
	 *
	 * This private method updates the published users array with the results
	 * from the network call, which will trigger UI updates.
	 *
	 * - Throws: Any error that might occur during the fetch operation
	 */
	@MainActor
	private func fetchAllUsers() async throws {
		guard let currentUID = Auth.auth().currentUser?.uid else { return }
		/// Retrieves all users and filters out the currently authenticated user.
		let users = try await UserService.fetchAllUsers(limit: 10)
		self.users = users.filter { $0.id != currentUID }
	}
}

