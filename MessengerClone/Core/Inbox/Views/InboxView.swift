//
//  InboxView.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/3/23.
//

import SwiftUI

struct InboxView: View {
	
	// MARK: - Properties
	@State private var showNewMessageView = false
	@StateObject var viewModel = InboxViewViewModel()
	
	private var user: User? {
		return viewModel.currentUser
	}
	
	// MARK: - View Body
    var body: some View {
		
		NavigationStack {
			
			ScrollView {
				ActiveNowView()
				
				List {
					ForEach(0...7, id: \.self) { message in
						InboxRowView()
					}
				}
				.listStyle(.plain)
				.frame(height: UIScreen.main.bounds.height - 120)
			}
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
