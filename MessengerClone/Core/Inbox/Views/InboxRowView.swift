//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxRowView: View {
	
	let message: Message
	
	// MARK: - View Body
    var body: some View {
		
		HStack(alignment: .top, spacing: 12) {
			
			CircularProfileImageView(
				user: message.user,
				size: .medium
			)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(message.user?.fullName ?? "")
					.font(.subheadline)
					.fontWeight(.semibold)
				
				Text(message.messageText)
					.font(.subheadline)
					.foregroundColor(.gray)
					.lineLimit(2)
					.frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
			}
			
			HStack {
				Text(message.timeStampString)
				Image(systemName: "chevron.right")
			}
			.font(.footnote)
			.foregroundColor(.gray)
			
		}
		.frame(height: 72)
    }
}
