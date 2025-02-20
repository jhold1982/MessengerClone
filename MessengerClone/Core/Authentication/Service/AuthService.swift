//
//  AuthService.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthService {
	
	@Published var userSession: FirebaseAuth.User?
	
	static let shared = AuthService()
	
	init() {
		self.userSession = Auth.auth().currentUser
		print("DEBUG: USER SESSION ID IS \(String(describing: userSession?.uid))")
	}
	
	func login(withEmail email: String, password: String) async throws {
		do {
			let result = try await Auth.auth().signIn(withEmail: email, password: password)
			self.userSession = result.user
		} catch {
			print("DEBUG: FAILED TO LOG USER IN WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	func createUser(withEmail email: String, password: String, fullName: String) async throws {
		do {
			let result = try await Auth.auth().createUser(withEmail: email, password: password)
			self.userSession = result.user
		} catch {
			print("DEBUG: FAILED TO CREATE USER WITH ERROR: \(error.localizedDescription)")
		}
	}
	
	func signOut() {
		do {
			try Auth.auth().signOut()
			self.userSession = nil
		} catch {
			print("DEBUG: FAILED TO LOG USER OUT. \(error.localizedDescription)")
		}
	}
}
