//
//  CircularProfileImageView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/11/23.
//

import SwiftUI

enum ProfileImageSize {
	case xxSmall
	case xSmall
	case small
	case medium
	case large
	case xLarge
	
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

struct CircularProfileImageView: View {
	
	// MARK: - PROPERTIES
	let user: User
	let size: ProfileImageSize
	
	// MARK: - VIEW BODY
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

// MARK: - PREVIEWS
struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
		CircularProfileImageView(user: User.mockUser, size: .xLarge)
    }
}
