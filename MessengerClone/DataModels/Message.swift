//
//  Message.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/4/25.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
/// A struct representing a message in a chat application, conforming to Identifiable, Codable, and Hashable protocols.
///
/// This struct is designed to work with Firebase Firestore and provides convenient properties for handling chat messages.
///
/// - Note: Requires Firebase and FirebaseFirestore frameworks to be imported.
struct Message: Identifiable, Codable, Hashable {
	/// A unique identifier for the message, mapped to the Firestore document ID.
	///
	/// This property is optional and can be automatically generated if not provided.
	@DocumentID public var messageID: String?
	
	/// The user ID of the message sender.
	let fromID: String
	
	/// The user ID of the message recipient.
	let toID: String
	
	/// The text content of the message.
	let messsageText: String
	
	/// The timestamp of when the message was sent.
	let timestamp: Timestamp
	
	/// An optional User object associated with the message sender.
	var user: User?
	
	/// A unique identifier for the message.
	///
	/// If a `messageID` is not provided, a new UUID is generated.
	///
	/// - Returns: A unique string identifier for the message.
	var id: String {
		return messageID ?? NSUUID().uuidString
	}
	
	/// Determines the ID of the chat partner.
	///
	/// - Returns: The user ID of the other participant in the chat.
	/// - Note: Uses the current authenticated user's ID for comparison.
	var chatPartnerID: String {
		return fromID == Auth.auth().currentUser?.uid ? toID : fromID
	}
	
	/// Checks if the message was sent by the current user.
	///
	/// - Returns: A boolean indicating whether the message is from the current authenticated user.
	var isFromCurrentUser: Bool {
		return fromID == Auth.auth().currentUser?.uid
	}
	
//	/// Coding keys for Codable conformance.
//	///
//	/// Allows for custom encoding and decoding of the Message struct.
//	private enum CodingKeys: String, CodingKey {
//		case messageID
//		case fromID
//		case toID
//		case messsageText
//		case timestamp
//		case user
//	}
}
