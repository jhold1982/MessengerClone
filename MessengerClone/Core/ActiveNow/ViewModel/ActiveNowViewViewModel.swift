//
//  ActiveNowViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/19/25.
//

import Foundation

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
	private func fetchAllUsers() async throws {
		self.users = try await UserService.fetchAllUsers()
	}
}

