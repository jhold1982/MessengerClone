//
//  InboxViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 2/26/25.
//

import Foundation
import Firebase
import Combine

/// A view model for managing the state of the inbox view.
///
/// This class conforms to the `ObservableObject` protocol, allowing SwiftUI views
/// to observe changes to its published properties and update accordingly.
///
/// ## Overview
///
/// The `InboxViewViewModel` provides access to the current user's data for the inbox view.
/// It subscribes to changes in the shared `UserService` to keep the current user information
/// up-to-date automatically.
///
/// ## Published Properties
///
/// - `currentUser`: The currently logged-in user. When this value changes, any SwiftUI view
///   observing this view model will be updated.
///
/// ## Example Usage
///
/// ```swift
/// struct InboxView: View {
///     @StateObject private var viewModel = InboxViewViewModel()
///
///     var body: some View {
///         VStack {
///             if let user = viewModel.currentUser {
///                 Text("Welcome \(user.name)")
///                 // ...inbox content
///             } else {
///                 Text("Please log in")
///             }
///         }
///     }
/// }
/// ```
class InboxViewViewModel: ObservableObject {
	/// The currently authenticated user.
	///
	/// This property is updated automatically when the user in `UserService` changes.
	/// When this property changes, any views observing this view model will be updated.
	@Published var currentUser: User?
	
	/// A set of cancellables to store active subscribers.
	private var cancellables = Set<AnyCancellable>()
	
	/// Initializes a new inbox view model and sets up subscribers.
	init() {
		setupSubscribers()
	}
	
	/// Sets up subscribers to external data sources.
	///
	/// This method establishes a subscription to the current user from the
	/// `UserService.shared` singleton. When the current user changes in the service,
	/// this view model's `currentUser` property will be updated automatically.
	///
	/// The subscriber uses a weak reference to self to prevent potential memory leaks.
	
	private func setupSubscribers() {
		UserService.shared.$currentUser.sink { [weak self] user in
			DispatchQueue.main.async {
				self?.currentUser = user
			}
		}.store(in: &cancellables)
	}
}
