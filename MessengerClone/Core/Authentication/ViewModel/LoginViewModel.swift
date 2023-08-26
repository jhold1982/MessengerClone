//
//  LoginViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
	
	// MARK: - PROPERTIES
	@Published var email = ""
	@Published var password = ""
	
	
	// MARK: - METHODS
	func login() async throws {
		try await AuthService.shared.login(withEmail: email, password: password)
	}
}
