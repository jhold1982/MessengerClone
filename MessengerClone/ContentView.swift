//
//  ContentView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - PROPERTIES
	@State private var isLoginViewActive = true
	
	
	// MARK: - BODY
    var body: some View {
		if isLoginViewActive {
			LoginView()
		} else {
			RegistrationView()
		}
    }
}

// MARK: - PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
