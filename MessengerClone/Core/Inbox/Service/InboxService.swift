//
//  InboxService.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/7/25.
//

import Foundation
import Firebase
import FirebaseFirestore

/**
 # InboxService
 
 A service class that handles observation and management of recent messages in a user's inbox.
 
 This class provides functionality to observe changes to the most recent messages in the current
 user's inbox by establishing a real-time listener to Firestore. It maintains a published array
 of document changes that other components can observe.
 
 ## Overview
 
 `InboxService` uses Firebase Firestore to listen for changes to the user's recent messages
 collection. When changes occur, it updates its published `documentChanges` array, which can
 be observed by SwiftUI views or other components of the application.
 */
class InboxService {
	
	/// Published array of document changes that updates when new messages are added or existing messages are modified.
	/// Observers of this property will be notified when changes occur.
	@Published var documentChanges = [DocumentChange]()
	
	/**
	 Establishes a real-time listener to observe recent messages for the current authenticated user.
	 
	 This method sets up a Firestore snapshot listener that tracks changes to the user's
	 "recent-messages" collection. The listener filters for documents that have been added or
	 modified, and updates the `documentChanges` array with these changes.
	 
	 The messages are ordered by timestamp in descending order, ensuring the most recent
	 messages appear first.
	 
	 - Note: This method requires an authenticated user. If no user is signed in, the method
			 will return early without establishing a listener.
	 */
	func observeRecentMessages() {
		// Ensure the user is authenticated before proceeding
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		// Create a query to the user's recent-messages collection, sorted by timestamp (newest first)
		let query = FirestoreConstants.messagesCollection.document(uid).collection("recent-messages").order(by: "timestamp", descending: true)
		
		// Establish a real-time listener for changes to the collection
		query.addSnapshotListener { snapshot, _ in
			// Filter for added or modified documents
			guard let changes = snapshot?.documentChanges.filter({ $0.type == .added || $0.type == .modified }) else { return }
			
			// Update the published property with the new changes
			self.documentChanges = changes
		}
	}
}
