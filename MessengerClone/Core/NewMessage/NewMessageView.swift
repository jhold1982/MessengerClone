//
//  NewMessageView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct NewMessageView: View {
	
	// MARK: - PROPERTIES
	@State private var searchText = ""
	@Environment(\.dismiss) var dismiss
	
	// MARK: - BODY
    var body: some View {
		NavigationStack {
			ScrollView {
				TextField("To:", text: $searchText)
					.frame(height: 44)
					.padding(.leading)
					.background(Color(.systemGroupedBackground))
				Text("CONTACTS")
					.foregroundColor(.gray)
					.font(.footnote)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				ForEach(0...10, id: \.self) { user in
					VStack {
						HStack {
							CircularProfileImageView(user: User.mockUser, size: .small)
							Text("firstName")
								.font(.subheadline)
								.fontWeight(.semibold)
							Spacer()
						} //: END OF HSTACK
						.padding(.leading)
					} //: END OF VSTACK
					Divider()
						.padding(.leading, 40)
				} //: END OF FOREACH
			} //: END OF SCROLLVIEW
			.navigationTitle("New Message")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}
					.foregroundColor(.black)
				}
			} //: END OF TOOLBAR
		} //: END OF NAVIGATION STACK
    } //: END OF VIEW BODY
	
	// MARK: - FUNCTIONS
}

// MARK: - PREVIEWS
struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			NewMessageView()
		}
    }
}
