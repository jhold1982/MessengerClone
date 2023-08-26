//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import SwiftUI

struct ChatMessageCell: View {
	
	// MARK: - PROPERTIES
	let isFromCurrentUser: Bool
	
	
	
	// MARK: - VIEW BODY
    var body: some View {
		HStack {
			if isFromCurrentUser {
				Spacer() // Moves chat to right side of screen
				Text("This is a test message for now asdf asfd")
					.font(.subheadline)
					.padding(12)
					.background(Color(.systemBlue))
					.foregroundColor(.white)
					.clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
					.frame(
						maxWidth: UIScreen.main.bounds.width / 1.5,
						alignment: .trailing
					)
			} else {
				HStack(alignment: .bottom, spacing: 8) {
					CircularProfileImageView(user: User.mockUser, size: .xxSmall)
					
					Text("This is a test message for now asdf asdf asdfasdf asdfasdfasdf")
						.font(.subheadline)
						.padding()
						.background(Color(.systemGray5))
						.foregroundColor(.black)
						.clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
						.frame(
							maxWidth: UIScreen.main.bounds.width / 1.75,
							alignment: .leading
						)
					Spacer() // moves chat to left side of screen
				}
			}
		} //: END OF HSTACK
		.padding(.horizontal, 8)
    }//: END OF VIEW BODY
}

// MARK: - PREVIEWS
struct ChatMessageCell_Previews: PreviewProvider {
    static var previews: some View {
		ChatMessageCell(isFromCurrentUser: false)
    }
}
