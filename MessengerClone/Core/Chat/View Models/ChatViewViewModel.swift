//
//  ChatViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/5/25.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class ChatViewViewModel: ObservableObject {
	
	@Published var messageText: String = ""
	@Published var messages = [Message]()
	
	let service: ChatService
	
	init(user: User) {
		self.service = ChatService(chatPartner: user)
		observeMessages()
	}
	
	func sendMessage() {
		service.sendMessage(messageText)
	}
	
	func observeMessages() {
		service.observeMessages() { message in
			self.messages.append(contentsOf: self.messages)
		}
	}
}
