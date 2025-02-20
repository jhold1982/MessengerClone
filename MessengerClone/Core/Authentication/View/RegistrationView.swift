//
//  RegistrationView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/30/23.
//

import SwiftUI

struct RegistrationView: View {
	
	// MARK: - Properties
	@StateObject var viewModel = RegistrationViewModel()
	@Environment(\.dismiss) var dismiss
	
	
	// MARK: - View Body
	var body: some View {
		
		VStack {
			Spacer()
			Image("MessengerLogo")
				.resizable()
				.scaledToFit()
				.frame(width: 150, height: 150)
				.padding()
			
			VStack {
				TextField("Email", text: $viewModel.email)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
				
				TextField("Full Name", text: $viewModel.fullName)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
				
				SecureField("Password", text: $viewModel.password)
					.textInputAutocapitalization(.never)
					.modifier(TextFieldModifier())
			}
			
			
			Button {
				Task { try await viewModel.createUser() }
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
		}
	}
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
