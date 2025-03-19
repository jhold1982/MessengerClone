//
//  ActiveNowView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

/**
 * ActiveNowView
 *
 * A SwiftUI view that displays horizontally scrollable profile images of currently active users.
 * Each profile shows an online indicator and the user's first name.
 */
struct ActiveNowView: View {
	
	// MARK: - Properties
	
	/**
	 * The view model that provides and manages user data.
	 * Using @StateObject ensures the view model persists across view updates
	 * and is only initialized once during the view's lifecycle.
	 */
	@StateObject var viewModel = ActiveNowViewViewModel()
	
	// MARK: - View Body
	
	/**
	 * The body of the view defining its visual appearance and layout.
	 * Creates a horizontal scrolling list of active user profiles with online status indicators.
	 */
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 22) {
				ForEach(viewModel.users, id: \.self) { user in
					NavigationLink(value: Route.chatView(user)) {
						VStack {
							// Profile image with online indicator overlay
							ZStack(alignment: .bottomTrailing) {
								// User profile image
								CircularProfileImageView(
									user: user,
									size: .medium
								)
								
								// Online status indicator
								ZStack {
									// White background circle
									Circle()
										.fill(.white)
										.frame(width: 18, height: 18)
									
									// Green online indicator
									Circle()
										.fill(Color(.systemGreen))
										.frame(width: 12, height: 12)
								}
							}
							
							// User's first name
							Text(user.firstName)
								.font(.footnote)
								.foregroundColor(.gray)
						}
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
