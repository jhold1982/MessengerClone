//
//  ChatViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/5/25.
//

import Foundation
import Firebase
import FirebaseFirestore

class ChatViewViewModel: ObservableObject {
	
	@Published var messageText: String = ""
	
	let user: User
	
	init(user: User) {
		self.user = user
	}
	
	func sendMessage() {
		
	}
}
