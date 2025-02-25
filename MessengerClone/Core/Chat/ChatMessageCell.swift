//
//  ChatMessageCell.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import SwiftUI

/**
 A SwiftUI view that displays a single message in a chat interface.
 
 `ChatMessageCell` renders a message bubble with different appearances depending on whether
 the message is from the current user or another user. Current user messages appear on the right
 with a blue background, while other users' messages appear on the left with their profile image
 and a gray background.
 
 ## Features
 - Adapts layout based on message sender (current user vs. other users)
 - Automatically aligns messages from current user to the right
 - Displays profile image for messages from other users
 - Uses the `ChatBubble` shape for consistent message styling
 - Limits message width relative to screen size for better readability
 - Different background colors to distinguish between sent and received messages
 
 ## Example
 ```swift
 // Display a message from the current user
 ChatMessageCell(isFromCurrentUser: true)
 
 // Display a message from another user
 ChatMessageCell(isFromCurrentUser: false)
 ```
 */
struct ChatMessageCell: View {
	
	// MARK: - Properties
	
	/// Determines the appearance and alignment of the message.
	/// - `true`: Message appears on the right side with blue background (sent by current user)
	/// - `false`: Message appears on the left side with gray background and profile image (received from another user)
	let isFromCurrentUser: Bool
	
	// MARK: - View Body
	
	/**
	 Constructs the view hierarchy for the message cell.
	 
	 The body adapts its layout and styling based on who sent the message:
	 - Current user messages are right-aligned with blue bubbles
	 - Other user messages are left-aligned with gray bubbles and include a profile image
	 
	 Both message types use the `ChatBubble` shape for consistent rounded corners,
	 and both limit their width based on the device screen size.
	 */
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
					/**
					 Displays the sender's profile image.
					 
					 Note: Currently using a mock user. In a production app,
					 this would display the actual message sender's profile image.
					 */
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
					Spacer()
				}
			}
		}
		.padding(.horizontal, 8)
	}
}

/**
 A preview provider for the `ChatMessageCell` view.
 
 This preview shows how a message from another user would appear in the Xcode canvas.
 You can modify the `isFromCurrentUser` parameter to preview both message types.
 */
struct ChatMessageCell_Previews: PreviewProvider {
	static var previews: some View {
		ChatMessageCell(isFromCurrentUser: false)
	}
}
