//
//  ProfileView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/5/23.
//

import SwiftUI

struct ProfileView: View {
	
	// MARK: - PROPERTIES
	
	
	
	// MARK: - BODY
    var body: some View {
		VStack {
			
			// MARK: - HEADER
			VStack {
				Image(systemName: "person.circle.fill")
					.resizable()
					.frame(width: 80, height: 80)
					.foregroundColor(Color(.systemGray4))
				
				Text("firstName")
					.font(.title2)
					.fontWeight(.semibold)
			} //: END OF INNER VSTACK
			
			// MARK: - LIST
			List {
				Section { 
					ForEach(SettingsOptionsViewModel.allCases) { option in
						HStack {
							Image(systemName: option.imageName)
								.resizable()
								.frame(width: 24, height: 24)
								.foregroundColor(option.imageBackgroundColor)
							Text(option.title)
								.font(.subheadline)
						}
					}
				} //: END OF TOP SECTION
				
				Section {
					Button("Log Out") {
						//
					}
					Button("Delete Account") {
						//
					}
				} //: END OF BOTTOM SECTION
				.foregroundColor(.red)
				
			} //: END OF LIST
		} //: END OF BODY VSTACK
    } //: END OF VIEW BODY
	
	// MARK: - FUNCTIONS
	
}

// MARK: - PREVIEWS
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
