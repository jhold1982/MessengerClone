//
//  ChatViewViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/5/25.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A view model that manages chat functionality for a messaging interface.
///
/// This class handles sending messages and observing new messages from a chat service.
/// It maintains the state of the current conversation and provides methods to interact
/// with the underlying chat service.
@MainActor
class ChatViewViewModel: ObservableObject {
	/// The current text being composed by the user.
	@Published var messageText: String = ""
	
	/// An array of messages in the current conversation.
	@Published var messages = [Message]()
	
	/// The service responsible for sending and receiving messages.
	let service: ChatService
	
	/// Initializes a new view model with the specified chat partner.
	///
	/// - Parameter user: The user who will be the recipient of messages in this chat.
	init(user: User) {
		self.service = ChatService(chatPartner: user)
		observeMessages()
	}
	
	/// Sends the current message text to the chat partner.
	///
	/// This method sends the current `messageText` through the chat service.
	/// After sending, the view should typically clear the message text.
	func sendMessage() {
		service.sendMessage(messageText)
	}
	
	/// Begins observing incoming messages from the chat service.
	///
	/// This method sets up a subscription to receive new messages from the chat service
	/// and adds them to the local `messages` array when they arrive.
	/// Note: There appears to be a bug in the implementation as it's currently appending
	/// the existing messages to themselves rather than appending the new message.
	func observeMessages() {
		service.observeMessages() { message in
			// FIXME: This implementation will duplicate all existing messages.
			// Should likely be: self.messages.append(message)
			self.messages.append(contentsOf: self.messages)
		}
	}
}
