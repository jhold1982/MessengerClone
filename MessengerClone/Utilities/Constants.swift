//
//  Constants.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/6/25.
//

import Foundation
import Firebase

struct FirestoreConstants {
	
	static let userCollection = Firestore.firestore().collection("users")
	
	static let messagesCollection = Firestore.firestore().collection("messages")
	
	
}
