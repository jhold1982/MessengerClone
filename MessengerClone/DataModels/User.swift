//
//  User.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/7/23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
	
	var id = NSUUID().uuidString
	let fullName: String
	let email: String
	var profileImageURL: String?
}

extension User {
	
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
