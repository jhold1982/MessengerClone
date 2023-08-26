//
//  InboxRowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxRowView: View {
	
	// MARK: - PROPERTIES
	
	
	
	// MARK: - BODY
    var body: some View {
		HStack(alignment: .top, spacing: 12) {
			CircularProfileImageView(user: User.mockUser, size: .medium)
			
			VStack(alignment: .leading, spacing: 4) {
				Text("firstName")
					.font(.subheadline)
					.fontWeight(.semibold)
				
				Text("Lorem Ipsum Dolar")
					.font(.subheadline)
					.foregroundColor(.gray)
					.lineLimit(2)
					.frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
			} //: END OF VSTACK
			HStack {
				Text("Yesterday")
				Image(systemName: "chevron.right")
			} //: END OF TIMESTAMP HSTACK
			.font(.footnote)
			.foregroundColor(.gray)
			
		} //: END OF HSTACK
		.frame(height: 72)
    } //: END OF BODY VIEW
	
	// MARK: - FUNCTIONS
}


// MARK: - PREVIEWS
struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView()
    }
}
