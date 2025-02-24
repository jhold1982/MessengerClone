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
	@Environment(\.dismiss) var dismiss
	
	
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
				
				ForEach(0...10, id: \.self) { user in
					VStack {
						HStack {
							CircularProfileImageView(
								user: User.mockUser,
								size: .small
							)
							
							Text("firstName")
								.font(.subheadline)
								.fontWeight(.semibold)
							
							Spacer()
						}
						.padding(.leading)
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
			NewMessageView()
		}
    }
}
