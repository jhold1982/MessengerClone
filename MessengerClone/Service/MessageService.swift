//
//  MessageService.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/4/25.
//

import Foundation
import Firebase
import FirebaseFirestore

/// A service responsible for handling message-related operations in a chat application.
///
/// This service manages sending messages between users using Firebase Firestore as the backend.
/// It handles the creation and storage of messages for both the sender and recipient.
///
/// - Note: Requires Firebase Authentication and Firestore to be properly configured in the project.
/// - Requires: Import FirebaseAuth and FirebaseFirestore
struct MessageService {
	/// A reference to the Firestore collection for storing messages.
	///
	/// The collection path is set to "messages" and serves as the root collection
	/// for all message-related document storage.
	private let messagesCollection = Firestore.firestore().collection("messages")
	
	/// Sends a message from the current user to a specified recipient.
	///
	/// This method creates message documents in Firestore for both the sender and recipient,
	/// ensuring that each user can view the message in their conversation history.
	///
	/// - Parameters:
	///   - messageText: The text content of the message to be sent.
	///   - user: The recipient of the message.
	///
	/// - Important: Requires the current user to be authenticated.
	///
	/// - Throws: Will silently return if the current user is not authenticated or
	///           if message encoding fails.
	///
	/// - SeeAlso: `Message` struct for message data model
	func sendMessage(_ messageText: String, toUser user: User) {
		// Authenticate and validate current user
		guard let currentUID = Auth.auth().currentUser?.uid else { return }
		
		let chatPartnerID = user.id
		
		// Create references for both sender and recipient message collections
		let currentUserRef = messagesCollection.document(currentUID).collection(chatPartnerID).document()
		let chatPartnerRef = messagesCollection.document(chatPartnerID).collection(currentUID)
		
		// Generate a unique message ID
		let messageID = currentUserRef.documentID
		
		// Create message model
		let message = Message(
			messageID: messageID,
			fromID: currentUID,
			toID: chatPartnerID,
			messageText: messageText,
			timestamp: Timestamp()
		)
		
		// Encode message to Firestore-compatible format
		guard let messageData = try? Firestore.Encoder().encode(message) else { return }
		
		// Store message for current user
		currentUserRef.setData(messageData)
		
		// Store message for chat partner
		chatPartnerRef.document(messageID).setData(messageData)
	}
}
