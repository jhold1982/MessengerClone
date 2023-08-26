//
//  ActiveNowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct ActiveNowView: View {
	
	// MARK: - PROPERTIES
	
	
	
	// MARK: - BODY
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 22) {
				ForEach(0...10, id: \.self) { user in
					VStack {
						ZStack(alignment: .bottomTrailing) {
							CircularProfileImageView(user: User.mockUser, size: .medium)
							
							ZStack {
								Circle()
									.fill(.white)
									.frame(width: 18, height: 18)
								
								Circle()
									.fill(Color(.systemGreen))
									.frame(width: 12, height: 12)
							} //: END OF INNER ZSTACK
						} //: END OUT OUTER ZSTACK
						Text("firstName")
							.font(.subheadline)
							.foregroundColor(.gray)
					} //: END OF VSTACK
				} //: END OF FOR EACH
			} //: END OF HSTACK
			.padding()
		} //: END OF SCROLLVIEW
		.frame(height: 106)
    }
}

// MARK: - PREVIEWS
struct ActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNowView()
    }
}
