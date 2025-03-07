//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/5/23.
//

import SwiftUI
import PhotosUI

/// A view that displays a user's profile with various settings options.
///
/// This view shows the user's profile image and name at the top, followed by
/// a list of settings options and account management buttons.
struct ProfileView: View {

	// MARK: - Properties
	
	/// The view model that manages the profile view state and logic.
	/// Initialized with a default instance of ProfileViewModel.
	@StateObject var viewModel = ProfileViewModel()
	
	/// The user whose profile is being displayed.
	/// This user's information is used to populate the profile details.
	let user: User

	// MARK: - View Body
	
	/// The body of the profile view defining its layout and appearance.
	var body: some View {
		VStack {
			// Profile header section containing the profile image and name
			VStack {
				// PhotosPicker allows the user to select a photo from their library
				// to use as their profile image
				PhotosPicker(selection: $viewModel.selectedItem) {
					// Display either the user-selected profile image or the default circular profile image
					if let profileImage = viewModel.profileImage {
						// Display the selected profile image with appropriate styling
						profileImage
							.resizable()
							.scaledToFill()
							.frame(width: 80, height: 80)
							.clipShape(Circle())
					} else {
						// Display the default profile image from the user object
						CircularProfileImageView(user: user, size: .xLarge)
					}
				}
				
				// Display the user's full name below their profile image
				Text(user.fullName)
					.font(.title2)
					.fontWeight(.semibold)
			}
			
			// Settings options list
			List {
				// Section containing the settings options
				Section {
					// Iterate through all available settings options
					ForEach(SettingsOptionsViewModel.allCases) { option in
						// Create a row for each setting option
						HStack {
							// Icon for the settings option
							Image(systemName: option.imageName)
								.resizable()
								.frame(width: 24, height: 24)
								.foregroundColor(option.imageBackgroundColor)
							
							// Title of the settings option
							Text(option.title)
								.font(.subheadline)
						}
					}
				}
				
				// Account management section
				Section {
					// Log out button with action to sign out the user
					Button("Log Out") {
						AuthService.shared.signOut()
					}
					
					// Delete account button (action not implemented yet)
					Button("Delete Account") {
						// TODO: Implement account deletion functionality
					}
				}
				.foregroundColor(.red) // Make the account management buttons red to indicate destructive actions
			}
		}
	}
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
		ProfileView(user: User.mockUser)
    }
}
