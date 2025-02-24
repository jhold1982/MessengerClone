//
//  CircularProfileImageView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/11/23.
//

import SwiftUI

/**
 A sizing enumeration that defines standard dimensions for profile images.
 
 This enum provides a consistent set of size options for profile images throughout
 the application, ensuring visual coherence and simplifying implementation.
 
 ## Usage
 ```swift
 let imageSize = ProfileImageSize.medium
 let dimension = imageSize.dimension // Returns 56
 ```
 */
enum ProfileImageSize {
	/// Extra extra small size (28pt)
	case xxSmall
	/// Extra small size (32pt)
	case xSmall
	/// Small size (40pt)
	case small
	/// Medium size (56pt)
	case medium
	/// Large size (64pt)
	case large
	/// Extra large size (80pt)
	case xLarge
	
	/**
	 Returns the pixel dimension associated with the specified size.
	 
	 - Returns: A `CGFloat` representing the width and height dimension in points.
	 */
	var dimension: CGFloat {
		switch self {
		case .xxSmall:
			return 28
		case .xSmall:
			return 32
		case .small:
			return 40
		case .medium:
			return 56
		case .large:
			return 64
		case .xLarge:
			return 80
		}
	}
}

/**
 A SwiftUI view that displays a circular profile image.
 
 This view handles both cases where a user has a profile image and where they don't,
 providing appropriate fallback imagery. The view automatically clips the image to a
 circular shape and adapts to different size requirements using the `ProfileImageSize` enum.
 
 ## Example
 ```swift
 CircularProfileImageView(user: currentUser, size: .medium)
 ```
 */
struct CircularProfileImageView: View {
	
	// MARK: - Properties
	
	/// The user whose profile image should be displayed
	let user: User
	
	/// The size of the profile image, using the `ProfileImageSize` enum
	let size: ProfileImageSize
	
	// MARK: - View Body
	
	/**
	 Constructs the view hierarchy for the profile image.
	 
	 If the user has a profile image URL, it displays that image.
	 Otherwise, it shows a system-provided person icon as a fallback.
	 */
	var body: some View {
		if let imageURL = user.profileImageURL {
			Image(imageURL)
				.resizable()
				.scaledToFill()
				.frame(width: size.dimension, height: size.dimension)
				.clipShape(Circle())
		} else {
			Image(systemName: "person.circle.fill")
				.resizable()
				.frame(width: size.dimension, height: size.dimension)
				.foregroundColor(Color(.systemGray4))
		}
	}
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
		CircularProfileImageView(user: User.mockUser, size: .xLarge)
    }
}
