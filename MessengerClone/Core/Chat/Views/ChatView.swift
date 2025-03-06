//
//  ChatView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/11/23.
//

import SwiftUI

/**
 A SwiftUI view that displays a messaging interface.
 
 `ChatView` presents a complete chat interface with a user profile section at the top,
 a scrollable message history in the middle, and a message input field at the bottom.
 The view handles displaying messages and provides a text field for composing new messages.
 
 ## Components
 - User profile display with image and name
 - Scrollable message history
 - Message input field with send button
 
 ## Example
 ```swift
 ChatView()
 ```
 */
struct ChatView: View {
	
	// MARK: - Properties
	
	/// View model that manages the chat functionality and state
	@StateObject var viewModel: ChatViewViewModel

	/// The user that the current user is chatting with
	let user: User

	/// Initializes a new chat view with the specified user
	/// - Parameter user: The user to chat with
	init(user: User) {
		self.user = user
		// Initialize the view model with the chat partner user
		self._viewModel = StateObject(wrappedValue: ChatViewViewModel(user: user))
	}
	
	// MARK: - View Body
	/**
	 Constructs the view hierarchy for the chat interface.
	 
	 The body consists of three main sections:
	 1. The profile header showing user information
	 2. A scrollable area containing message cells
	 3. A message composition area at the bottom with text field and send button
	 */
	var body: some View {
		VStack {
			// Scrollable message area
			ScrollView {
				// User profile header
				VStack {
					/**
					 Displays the user's profile image using the CircularProfileImageView.
					 
					 This uses a mock user for demonstration purposes and shows the image at extra large size.
					 In a production app, you would pass the actual conversation participant.
					 */
					CircularProfileImageView(user: user, size: .xLarge)
					
					// User information display
					VStack(spacing: 4) {
						/**
						 Displays the user's name.
						 
						 Note: Currently using a placeholder "userName" string.
						 This should be replaced with the actual user's name in production.
						 */
						Text(user.fullName)
							.font(.title3)
							.fontWeight(.semibold)
						
						/**
						 Displays the user's status or app name.
						 */
						Text("Messenger")
							.font(.footnote)
							.foregroundColor(.gray)
					}
				}
				
				// Message history
				/**
				 Generates a series of sample message cells.
				 
				 In a production app, this would be replaced with actual message data from a model,
				 likely using a more sophisticated data structure than a simple integer range.
				 */
				ForEach(viewModel.messages) { message in
					/**
					 Creates individual message cells with randomly assigned sender status.
					 
					 Note: The random assignment is for demonstration purposes only.
					 In a production app, each message would have a proper sender identifier.
					 */
					ChatMessageCell(message: message)
				}
			}
			
			Spacer()
			
			// Message composition area
			/**
			 A composable message input field with send button.
			 
			 This input area allows users to type multi-line messages and send them
			 with the adjacent send button.
			 */
			ZStack(alignment: .trailing) {
				/**
				 Text input field for composing messages.
				 
				 This field expands vertically to accommodate multi-line messages,
				 with styling to make it appear as a chat input bubble.
				 */
				TextField("Message...", text: $viewModel.messageText, axis: .vertical)
					.padding(12)
					.padding(.trailing, 48)
					.background(Color(.systemGroupedBackground))
					.clipShape(Capsule())
					.font(.subheadline)
				
				/**
				 Send button that triggers message sending.
				 
				 When tapped, this currently prints a debug message.
				 In a production app, this would call a method to process and send the message.
				 */
				Button {
					viewModel.sendMessage()
					viewModel.messageText = ""
				} label: {
					Text("Send")
						.fontWeight(.semibold)
				}
				.padding(.horizontal)
			}
			.padding()
		}
	}
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
		ChatView(user: User.mockUser)
    }
}
