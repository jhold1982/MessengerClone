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
	static let mockUser = User(fullName: "Example Name", email: "example@email.com", profileImageURL: "tool")
}
