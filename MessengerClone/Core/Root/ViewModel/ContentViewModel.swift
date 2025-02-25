//
//  ContentViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/26/23.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

/// A view model that observes and manages the current user session.
///
/// This class serves as a bridge between Firebase authentication and SwiftUI views
/// by making the current user session available as an observable property.
///
/// ## Overview
///
/// `ContentViewModel` observes the shared `AuthService` and updates its own user session
/// property whenever the authentication state changes. This allows SwiftUI views to reactively
/// update when a user signs in or out.
///
/// ## Example Usage
///
/// ```swift
/// struct ContentView: View {
///     @StateObject private var viewModel = ContentViewModel()
///
///     var body: some View {
///         if viewModel.userSession != nil {
///             MainTabView()
///         } else {
///             LoginView()
///         }
///     }
/// }
/// ```
class ContentViewModel: ObservableObject {
	/// The current authenticated user, or `nil` if no user is signed in.
	///
	/// This property updates automatically when the authentication state changes.
	/// SwiftUI views observing this view model will be redrawn when this value changes.
	@Published var userSession: FirebaseAuth.User?
	
	/// Storage for Combine cancellables to prevent premature subscription cancellation.
	private var cancellables = Set<AnyCancellable>()
	
	/// Creates a new instance of the view model and sets up authentication state observation.
	init() {
		setupSubscribers()
	}
	
	/// Sets up Combine subscribers to observe authentication state changes.
	///
	/// This method subscribes to the shared `AuthService`'s user session publisher and
	/// updates the view model's `userSession` property on the main thread whenever
	/// the authentication state changes.
	private func setupSubscribers() {
		AuthService.shared.$userSession
			.sink { [weak self] userSessionFromAuthService in
				DispatchQueue.main.async {
					self?.userSession = userSessionFromAuthService
				}
			}
			.store(in: &cancellables)
	}
}
