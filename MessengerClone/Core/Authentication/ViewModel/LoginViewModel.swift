//
//  LoginViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

/**
 A view model that manages the login state and operations.
 
 `LoginViewModel` handles the login form state and authentication process,
 following the MVVM (Model-View-ViewModel) pattern. It maintains the email
 and password input values and provides functionality to authenticate users
 through the AuthService.
 
 ## Features
 - Conforms to ObservableObject for SwiftUI data binding
 - Manages login form state (email and password)
 - Handles user authentication through AuthService
 - Publishes state changes to update the UI
 
 ## Example
 ```swift
 // In a SwiftUI view
 @StateObject private var viewModel = LoginViewModel()
 
 TextField("Email", text: $viewModel.email)
 SecureField("Password", text: $viewModel.password)
 
 Button("Login") {
	 Task {
		 try await viewModel.login()
	 }
 }
 ```
 */
class LoginViewModel: ObservableObject {
	
	/**
	 The user's email address input.
	 
	 This published property updates the UI whenever its value changes,
	 allowing for real-time form validation and response.
	 */
	@Published var email = ""
	
	/**
	 The user's password input.
	 
	 This published property updates the UI whenever its value changes,
	 allowing for real-time form validation and response.
	 */
	@Published var password = ""
	
	/**
	 Attempts to authenticate the user with the provided credentials.
	 
	 This method calls the `AuthService` to authenticate a user with the
	 email and password stored in the view model. It should be called when
	 the user submits the login form.
	 
	 - Throws: An error if the login attempt fails
	 
	 - Note: This is an asynchronous method that must be called within a Task
	   or another async context.
	 */
	func login() async throws {
		try await AuthService.shared.login(withEmail: email, password: password)
	}
}
