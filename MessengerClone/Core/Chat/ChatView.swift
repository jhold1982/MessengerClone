//
//  ChatView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/11/23.
//

import SwiftUI

struct ChatView: View {
	
	// MARK: - PROPERTIES
	@State private var messageText = ""
	
	// MARK: - VIEW BODY
    var body: some View {
		VStack {
			ScrollView {
				
				// MARK: - HEADER
				VStack {
					CircularProfileImageView(user: User.mockUser, size: .xLarge)
					
					VStack(spacing: 4) {
						Text("userName")
							.font(.title3)
							.fontWeight(.semibold)
						
						Text("Messenger")
							.font(.footnote)
							.foregroundColor(.gray)
					} //: END OF INNER VSTACK
				} //: END OF HEADER VSTACK
				
				// MARK: - MESSAGES
				ForEach(0...15, id: \.self) { message in
					ChatMessageCell(isFromCurrentUser: Bool.random())
				}
				
				
				
				
				
			} //: END OF SCROLLVIEW
			// MARK: - MESSAGE INPUT
			Spacer()
			ZStack(alignment: .trailing) {
				TextField("Message...", text: $messageText, axis: .vertical)
					.padding(12)
					.padding(.trailing, 48)
					.background(Color(.systemGroupedBackground))
					.clipShape(Capsule())
					.font(.subheadline)
				
				Button {
					print("DEBUG: SEND MESSAGE...")
				} label: {
					Text("Send")
						.fontWeight(.semibold)
				}
				.padding(.horizontal)
			} //: END OF INPUT ZSTACK
			.padding()
		} //: END OF OUTER VSTACK
    } //: END OF VIEW BODY
}

// MARK: - PREVIEWS
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
