//
//  SettingsOptionsViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/5/23.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
	
	case darkMode
	case activeStatus
	case accessibility
	case privacy
	case notifications
	
	var title: String {
		switch self {
		case .darkMode:
			return "Dark mode"
		case .activeStatus:
			return "Active status"
		case .accessibility:
			return "Accessibility"
		case .privacy:
			return "Privacy and Safety"
		case .notifications:
			return "Notifications"
		}
	}
	
	var imageName: String {
		switch self {
		case .darkMode:
			return "moon.circle.fill"
		case .activeStatus:
			return "message.badge.circle.fill"
		case .accessibility:
			return "person.circle.fill"
		case .privacy:
			return "lock.circle.fill"
		case .notifications:
			return "bell.circle.fill"
		}
	}
	
	var imageBackgroundColor: Color {
		switch self {
		case .darkMode:
			return .black
		case .activeStatus:
			return .green
		case .accessibility:
			return .blue
		case .privacy:
			return .purple
		case .notifications:
			return .red
		}
	}
	
	var id: Int { return self.rawValue }
}

/*
 This code defines a SwiftUI view model for a settings screen using an enum. Let me explain what it's doing:

 The `SettingsOptionsViewModel` is an enumeration that:

 1. Conforms to three Swift protocols:
	- `Int`: Uses integers as its raw value type
	- `CaseIterable`: Allows iterating through all enum cases
	- `Identifiable`: Makes it usable in SwiftUI lists with unique identifiers

 2. Defines five different settings options:
	```swift
	case darkMode
	case activeStatus
	case accessibility
	case privacy
	case notifications
	```

 3. Provides three computed properties for each settings option:

	- `title`: Returns a user-friendly string name for each setting
	  ```swift
	  var title: String {
		switch self {
		  case .darkMode: return "Dark mode"
		  case .activeStatus: return "Active status"
		  case .accessibility: return "Accessbility" // Note: has a typo ("Accessbility")
		  case .privacy: return "Privacy and Safety"
		  case .notifications: return "Notifications"
		}
	  }
	  ```

	- `imageName`: Returns SF Symbol icon names to visually represent each setting
	  ```swift
	  var imageName: String {
		switch self {
		  case .darkMode: return "moon.circle.fill"
		  case .activeStatus: return "message.badge.circle.fill"
		  case .accessibility: return "person.circle.fill"
		  case .privacy: return "lock.circle.fill"
		  case .notifications: return "bell.circle.fill"
		}
	  }
	  ```

	- `imageBackgroundColor`: Assigns a brand color to each setting icon
	  ```swift
	  var imageBackgroundColor: Color {
		switch self {
		  case .darkMode: return .black
		  case .activeStatus: return .green
		  case .accessibility: return .blue
		  case .privacy: return .purple
		  case .notifications: return .red
		}
	  }
	  ```

 4. Implements the `Identifiable` protocol by providing an `id` property that uses the enum's raw value:
	```swift
	var id: Int { return self.rawValue }
	```

 This enum would typically be used to build a settings screen in a SwiftUI app, where each option appears as a row in a list with the specified icon, background color, and title. The `CaseIterable` conformance makes it easy to iterate through all options to build the settings menu.
 
*/
