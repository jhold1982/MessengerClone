//
//  ChatService.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/6/25.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ChatService {
	
	let chatPartner: User
	
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
	func sendMessage(_ messageText: String) {
		// Authenticate and validate current user
		guard let currentUID = Auth.auth().currentUser?.uid else { return }
		
		let chatPartnerID = chatPartner.id
		
		// Create references for both sender and recipient message collections
		let currentUserRef = FirestoreConstants.messagesCollection.document(currentUID).collection(chatPartnerID).document()
		let chatPartnerRef = FirestoreConstants.messagesCollection.document(chatPartnerID).collection(currentUID)
		
		let recentCurrentUserRef = FirestoreConstants.messagesCollection.document(currentUID).collection("recent-messages").document(chatPartnerID)
		let recentPartnerRef = FirestoreConstants.messagesCollection.document(chatPartnerID).collection("recent-messages").document(currentUID)
		
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
		
		recentCurrentUserRef.setData(messageData)
		recentPartnerRef.setData(messageData)
	}
	
	/// Observes and retrieves messages for a specific chat partner in real-time.
	///
	/// This function sets up a Firebase Firestore snapshot listener to track new messages
	/// between the current user and a specified chat partner. It retrieves messages in
	/// chronological order and populates the user information for incoming messages.
	///
	/// - Parameters:
	///   - chatPartner: The `User` object representing the other participant in the chat.
	///   - completion: A closure that is called with an array of `Message` objects when new messages are detected.
	///                 The closure is executed on the main thread with the latest messages.
	///
	/// - Note: This function requires an authenticated Firebase user and assumes a specific
	///         Firestore collection structure for storing messages.
	///
	/// - Requires: Firebase Authentication and Firestore must be configured in the project.
	///
	/// - Returns: Void (uses a completion handler to pass messages)
	///
	/// - SeeAlso: `Message`, `User`
	func observeMessages(completion: @escaping([Message]) -> Void) {
		// Ensure current user is authenticated
		guard let currentUID = Auth.auth().currentUser?.uid else { return }
		
		let chatPartnerID = chatPartner.id
		
		// Create a Firestore query to fetch messages between current user and chat partner
		let query = FirestoreConstants.messagesCollection
			.document(currentUID)
			.collection(chatPartnerID)
			.order(by: "timestamp", descending: false)

		// Add a snapshot listener to track real-time message changes
		query.addSnapshotListener { snapshot, _ in
			// Filter only newly added documents
			guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
			
			// Convert document changes to Message objects
			var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
			
			// Attach chat partner user information to incoming messages
			for (index, message) in messages.enumerated() where message.fromID != currentUID {
				messages[index].user = chatPartner
			}
			
			// Call completion handler with retrieved messages
			completion(messages)
		}
	}
}
