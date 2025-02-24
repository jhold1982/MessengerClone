//
//  ContentView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - Properties
	@StateObject var viewModel = ContentViewModel()
	
	
	// MARK: - View Body
    var body: some View {
		Group {
			if $viewModel.userSession != nil {
				InboxView()
			} else {
				LoginView()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
