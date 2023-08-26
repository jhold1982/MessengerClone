//
//  InboxView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxView: View {
	
	// MARK: - PROPERTIES
	@State private var showNewMessageView = false
	@State private var user = User.mockUser
	
	// MARK: - BODY
    var body: some View {
		NavigationStack {
			ScrollView {
				ActiveNowView()
				
				List {
					ForEach(0...7, id: \.self) { message in
						InboxRowView()
					}
				} //: END OF LIST
				.listStyle(.plain)
				.frame(height: UIScreen.main.bounds.height - 120)
			} //: END OF SCROLLVIEW
			.navigationDestination(for: User.self, destination: { user in
				ProfileView(user: user)
			})
			.fullScreenCover(isPresented: $showNewMessageView, content: {
				NewMessageView()
			})
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					HStack {
						NavigationLink(value: user) {
							CircularProfileImageView(user: user, size: .xSmall)
						}
						Text("Chats")
							.font(.title)
							.fontWeight(.semibold)
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						showNewMessageView.toggle()
					} label: {
						Image(systemName: "square.and.pencil.circle.fill")
							.resizable()
							.frame(width: 32, height: 32)
							.foregroundStyle(.black, Color(.systemGray5))
					}
				}
			}
		} //: END OF NAVIGATION STACK
    } //: END OF VIEW BODY
}

// MARK: - PREVIEWS
struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
