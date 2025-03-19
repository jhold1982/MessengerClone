//
//  User.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/7/23.
//

import Foundation
import FirebaseFirestoreSwift

/// A model representing a user in the application.
///
/// This struct conforms to `Codable` for easy serialization to and from Firestore,
/// `Identifiable` for use in SwiftUI lists and ForEach, and `Hashable` for comparison operations.
///
/// ## Overview
///
/// The `User` model stores essential information about a user:
/// - A unique identifier sourced from Firestore
/// - The user's full name
/// - The user's email address
/// - An optional URL to the user's profile image
///
/// The model automatically generates an identifier if none is provided from Firestore.
///
/// ## Example Usage
///
/// ```swift
/// // Create a user from Firestore data
/// let user = try documentSnapshot.data(as: User.self)
///
/// // Display user in a SwiftUI view
/// Text(user.fullName)
/// ```
struct User: Codable, Identifiable, Hashable {
	/// The unique identifier for the user, typically from Firestore.
	///
	/// This property is marked with @DocumentID to automatically map to the document ID
	/// when decoded from a Firestore document.
	@DocumentID var uid: String?
	
	/// The user's full name.
	let fullName: String
	
	/// The user's email address.
	let email: String
	
	/// The URL string pointing to the user's profile image.
	///
	/// This is an optional property as a user might not have uploaded a profile image yet.
	var profileImageURL: String?
	
	/// A computed property that satisfies the `Identifiable` protocol.
	///
	/// Returns the Firestore document ID if available, otherwise generates a new UUID.
	var id: String {
		return uid ?? NSUUID().uuidString
	}
	
	/**
	 * A computed property that extracts the first name from a full name string.
	 *
	 * This property uses PersonNameComponentsFormatter to intelligently parse
	 * the stored fullName into components and extract just the given name (first name).
	 * If parsing fails or the given name component is not available, it falls back to
	 * returning the entire fullName.
	 *
	 * - Returns: The first name extracted from fullName, or the entire fullName if extraction fails.
	 *
	 * - Note: This property relies on PersonNameComponentsFormatter, which uses natural language
	 *         processing to handle various name formats across different cultures and languages.
	 */
	var firstName: String {
		// Create a name formatter to parse the full name
		let formatter = PersonNameComponentsFormatter()
		
		// Attempt to parse the fullName into components
		let components = formatter.personNameComponents(from: fullName)
		
		// Extract the given name (first name) or fall back to the full name if parsing fails
		return components?.givenName ?? fullName
	}
}

/// Extension providing test data for the User model.
extension User {
	/// A mock user instance for previews and testing.
	///
	/// This constant provides a consistent user representation for SwiftUI previews,
	/// unit tests, and UI development without requiring actual authentication.
	static let mockUser = User(
		fullName: "Example Name",
		email: "example@email.com",
		profileImageURL: "tool"
	)
}

/*
 # User Structure Documentation

 ## Overview
 `User` is a Swift structure that represents a user entity in the application. It conforms to several protocols:
 - `Codable`: Enables encoding/decoding for data persistence and network transfers
 - `Identifiable`: Allows for unique identification in SwiftUI collections
 - `Hashable`: Enables use in sets and as dictionary keys

 ## Properties

 | Property | Type | Description |
 |----------|------|-------------|
 | `id` | `String` | A unique identifier for the user, automatically generated using NSUUID |
 | `fullName` | `String` | The user's complete name |
 | `email` | `String` | The user's email address |
 | `profileImageURL` | `String?` | An optional URL string pointing to the user's profile image |

 ## Protocol Conformance Details

 ### Codable
 The `Codable` conformance allows the `User` structure to be:
 - Encoded to formats like JSON for network transmission or local storage
 - Decoded from external data sources back into `User` instances

 ### Identifiable
 The `Identifiable` protocol enables:
 - Efficient rendering in SwiftUI lists and other collections
 - Identification through the `id` property without additional configuration

 ### Hashable
 As a `Hashable` type, `User` instances can be:
 - Used as keys in dictionaries
 - Stored in sets
 - Compared efficiently for equality

 ## Extensions

 The `User` structure includes an extension that provides a mock user for testing and development:

 ```swift
 static let mockUser = User(
	 fullName: "Example Name",
	 email: "example@email.com",
	 profileImageURL: "tool"
 )
 ```

 This mock user can be used for:
 - UI previews in SwiftUI
 - Unit testing
 - Placeholder data during development
 */
