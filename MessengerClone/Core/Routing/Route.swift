//
//  Route.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/19/25.
//

import Foundation

enum Route: Hashable {
	
	case profile(User)
	case chatView(User)
}
