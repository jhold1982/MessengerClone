//
//  ChatBubble.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/22/23.
//

import SwiftUI

/**
 A custom shape that creates a chat bubble with appropriate corners rounded.
 
 `ChatBubble` implements the `Shape` protocol to define a chat message bubble
 with rounded corners. The bubble's appearance adapts based on whether it represents
 a message from the current user or another user, by changing which corners are rounded.
 
 ## Features
 - Dynamically adapts shape based on message sender
 - User messages have rounded corners on top-left, top-right, and bottom-left
 - Non-user messages have rounded corners on top-left, top-right, and bottom-right
 - Consistent corner radius of 16 points
 
 ## Example
 ```swift
 // For the current user's message bubble
 ChatBubble(isFromCurrentUser: true)
 
 // For another user's message bubble
 ChatBubble(isFromCurrentUser: false)
 ```
 */
struct ChatBubble: Shape {
	
	// MARK: - Properties
	
	/// Determines the shape of the bubble based on whether the message is from the current user.
	/// - `true`: Rounds top-left, top-right, and bottom-left corners (for current user's messages)
	/// - `false`: Rounds top-left, top-right, and bottom-right corners (for other users' messages)
	let isFromCurrentUser: Bool
	
	// MARK: - Shape Method
	
	/**
	 Creates a path that defines the chat bubble shape with appropriately rounded corners.
	 
	 This method implements the required `path(in:)` method from the `Shape` protocol,
	 creating a `UIBezierPath` with specific corners rounded based on the message sender.
	 
	 - Parameter rect: The rectangle in which to draw the path
	 - Returns: A `Path` representing the chat bubble shape
	 */
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: [
				.topLeft,
				.topRight,
				isFromCurrentUser ? .bottomLeft : .bottomRight
			],
			cornerRadii: CGSize(width: 16, height: 16)
		)
		return Path(path.cgPath)
	}
}

/**
 A preview provider for the `ChatBubble` shape.
 
 This preview shows how the chat bubble appears in the Xcode canvas.
 Note that this only previews the shape itself, not how it would look
 when used as a background for an actual chat message.
 */
struct ChatBubble_Previews: PreviewProvider {
	static var previews: some View {
		ChatBubble(isFromCurrentUser: true)
	}
}
