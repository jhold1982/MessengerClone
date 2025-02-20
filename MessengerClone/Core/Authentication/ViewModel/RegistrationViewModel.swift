//
//  RegistrationViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject {
	
	@Published var email = ""
	@Published var password = ""
	@Published var fullName = ""
	
	func createUser() async throws {
		try await AuthService.shared.createUser(
			withEmail: email,
			password: password,
			fullName: fullName
		)
	}
}
