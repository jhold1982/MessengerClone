//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxRowView: View {
	
	// MARK: - View Body
    var body: some View {
		
		HStack(alignment: .top, spacing: 12) {
			
			CircularProfileImageView(
				user: User.mockUser,
				size: .medium
			)
			
			VStack(alignment: .leading, spacing: 4) {
				Text("firstName")
					.font(.subheadline)
					.fontWeight(.semibold)
				
				Text("Lorem Ipsum Dolar")
					.font(.subheadline)
					.foregroundColor(.gray)
					.lineLimit(2)
					.frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
			}
			
			HStack {
				Text("Yesterday")
				Image(systemName: "chevron.right")
			}
			.font(.footnote)
			.foregroundColor(.gray)
			
		}
		.frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView()
    }
}
