//
//  LoginView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI

struct LoginView: View {
	
	// MARK: - PROPERTIES
	@StateObject var viewModel = LoginViewModel()
	
	
	// MARK: - BODY
    var body: some View {
		NavigationStack {
			VStack {
				
				// MARK: - HEADER
				Spacer()
				Image("MessengerLogo")
					.resizable()
					.scaledToFit()
					.frame(width: 150, height: 150)
					.padding()
				
				// MARK: - CENTER
				VStack {
					TextField("Email", text: $viewModel.email)
						.textInputAutocapitalization(.never)
						.modifier(TextFieldModifier())
					
					SecureField("Password", text: $viewModel.password)
						.textInputAutocapitalization(.never)
						.modifier(TextFieldModifier())
				} //: END OF CENTER VSTACK
				
				// FORGOT PASSWORD BUTTON
				Button {
					print("DEBUG: Forgot Password...")
				} label: {
					Text("Forgot Password?")
						.font(.footnote)
						.fontWeight(.semibold)
						.padding(.top)
						.padding(.trailing, 28)
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
				
				// LOG IN BUTTON
				Button {
					Task { try await viewModel.login() }
				} label: {
					Text("Login")
						.modifier(CustomButtonModifier())
				}
				.padding(.vertical)
				
				// MARK: - FOOTER
				// Custom "OR" Divider
				HStack {
					Rectangle()
						.frame(
							width: (UIScreen.main.bounds.width / 2) - 40,
							height: 0.5
						)
					
					Text("OR")
						.font(.footnote)
						.fontWeight(.semibold)
					
					Rectangle()
						.frame(
							width: (UIScreen.main.bounds.width / 2) - 40,
							height: 0.5
						)
				}
				.foregroundColor(.gray)
				
				// Continue with Facebook
				HStack {
					Image("FacebookLogo")
						.resizable()
						.frame(width: 20, height: 20)
					Text("Continue with Facebook")
						.font(.footnote)
						.fontWeight(.semibold)
						.foregroundColor(Color(.systemBlue))
				}
				.padding(.top, 8)
				
				Spacer()
				Divider()
				
				// SIGN UP
				NavigationLink {
					RegistrationView()
						.navigationBarBackButtonHidden()
				} label: {
					HStack(spacing: 3) {
						Text("Don't have an account?")
						Text("Sign Up")
							.fontWeight(.semibold)
					} //: END OF SIGN UP HSTACK
					.font(.footnote)
				} //: END OF NAVIGATION LINK
				.padding(.vertical, 16)
			} //: END OF OUTER VSTACK
			
		} //: END OF NAVIGATION STACK
		
    }
}

// MARK: - PREVIEWS
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
