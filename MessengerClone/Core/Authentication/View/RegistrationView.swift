//
//  RegistrationView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/30/23.
//

import SwiftUI

struct RegistrationView: View {
	
	// MARK: - PROPERTIES
	@State private var email = ""
	@State private var password = ""
	@State private var fullName = ""
	
	@Environment(\.dismiss) var dismiss
	
	// MARK: - BODY
	var body: some View {
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
				TextField("Email", text: $email)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
				
				TextField("Full Name", text: $fullName)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
				
				SecureField("Password", text: $password)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
			} //: END OF CENTER VSTACK
			
			// LOG IN BUTTON
			Button {
				  print("DEBUG: Sign Up...")
			  } label: {
				  Text("Sign Up")
					  .modifier(CustomButtonModifier())
			  }
			  .padding(.vertical)
			Spacer()
			Divider()
			Button {
				dismiss()
			} label: {
				HStack(spacing: 3) {
					Text("Already have an account?")
					Text("Log In")
						.fontWeight(.bold)
				}
				.font(.footnote)
			}
			.padding(.vertical)
		} //: END OF BODY VSTACK
	}
}

// MARK: - PREVIEWS
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
