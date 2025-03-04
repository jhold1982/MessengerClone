//
//  NewMessageView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct NewMessageView: View {
	
	// MARK: - Properties
	@State private var searchText = ""
	@StateObject var viewModel = NewMessageViewViewModel()
	@Environment(\.dismiss) var dismiss
	@Binding var selectedUser: User?
	
	
	// MARK: - View Body
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
				
				ForEach(viewModel.users) { user in
					VStack {
						HStack {
							CircularProfileImageView(
								user: user,
								size: .small
							)
							
							Text(user.fullName)
								.font(.subheadline)
								.fontWeight(.semibold)
							
							Spacer()
						}
						.padding(.leading)
					}
					.onTapGesture {
						selectedUser = user
						dismiss()
					}
					
					Divider()
						.padding(.leading, 40)
				}
			}
			.navigationTitle("New Message")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button("Cancel") {
						dismiss()
					}
					.tint(.red)
				}
			}
		}
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			NewMessageView(selectedUser: .constant(User.mockUser))
		}
    }
}
