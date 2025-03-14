//
//  InboxView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxView: View {
	
	// MARK: - Properties
	@StateObject var viewModel = InboxViewViewModel()
	
	@State private var showNewMessageView: Bool = false
	@State private var showChat: Bool = false
	
	@State private var selectedUser: User?
	
	private var user: User? {
		return viewModel.currentUser
	}
	
	// MARK: - View Body
    var body: some View {
		
		NavigationStack {
			
			ScrollView {
				ActiveNowView()
				
				List {
					ForEach(viewModel.recentMessages) { message in
						ZStack {
							NavigationLink(value: message) {
								EmptyView()
							}.opacity(0.0)
							
							InboxRowView(message: message)
						}
					}
				}
				.listStyle(.plain)
				.frame(height: UIScreen.main.bounds.height - 120)
			}
			.onChange(of: selectedUser, perform: { newValue in
				showChat = newValue != nil
			})
			.navigationDestination(for: Message.self, destination: { message in
				if let user = message.user {
					ChatView(user: user)
				}
			})
			.navigationDestination(for: User.self, destination: { user in
				ProfileView(user: user)
			})
			.navigationDestination(isPresented: $showChat, destination: {
				if let user = selectedUser {
					ChatView(user: user)
				}
			})
			.fullScreenCover(isPresented: $showNewMessageView, content: {
				NewMessageView(selectedUser: $selectedUser)
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
						selectedUser = nil
					} label: {
						Image(systemName: "square.and.pencil.circle.fill")
							.resizable()
							.frame(width: 32, height: 32)
							.foregroundStyle(.white, Color(.systemBlue))
					}
					.padding()
				}
			}
		}
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
