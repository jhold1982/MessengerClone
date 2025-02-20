//
//  ActiveNowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct ActiveNowView: View {
	
	// MARK: - View Body
    var body: some View {
		
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 22) {
				ForEach(0...10, id: \.self) { user in
					VStack {
						
						ZStack(alignment: .bottomTrailing) {
							
							CircularProfileImageView(
								user: User.mockUser,
								size: .medium
							)
							
							ZStack {
								Circle()
									.fill(.white)
									.frame(width: 18, height: 18)
								
								Circle()
									.fill(Color(.systemGreen))
									.frame(width: 12, height: 12)
							}
						}
						
						Text("firstName")
							.font(.subheadline)
							.foregroundColor(.gray)
						
					}
				}
			}
			.padding()
		}
		.frame(height: 106)
    }
}

struct ActiveNowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveNowView()
    }
}
