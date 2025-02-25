//
//  ContentView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI

/**
 The root view of the application that handles authentication state.
 
 `ContentView` serves as the main container view that conditionally displays either
 the `InboxView` for authenticated users or the `LoginView` for unauthenticated users.
 It observes the authentication state through a view model and updates the UI accordingly.
 
 ## Features
 - Manages app navigation based on authentication state
 - Uses StateObject to maintain view model lifecycle
 - Automatically transitions between authenticated and unauthenticated states
 
 ## View Flow
 - When `userSession` is nil: Shows the login screen
 - When `userSession` is not nil: Shows the main inbox/messaging interface
 
 ## Dependencies
 - Requires a `ContentViewModel` that exposes a `userSession` property
 - Depends on `LoginView` and `InboxView` components
 
 ## Example
 ```swift
 ContentView()
 ```
 */
struct ContentView: View {
	
	// MARK: - Properties
	
	/**
	 The view model that manages authentication state and related business logic.
	 
	 This property is declared as a `@StateObject` to ensure the view model persists
	 across view updates and maintains its state throughout the application lifecycle.
	 The view observes changes to `userSession` to determine which view to display.
	 */
	@StateObject var viewModel = ContentViewModel()
	
	// MARK: - View Body
	
	/**
	 Constructs the conditional view hierarchy based on authentication state.
	 
	 The body checks whether the user is authenticated by examining the `userSession`
	 property of the view model. It then renders either:
	 - `InboxView` if the user is authenticated (userSession is not nil)
	 - `LoginView` if the user is not authenticated (userSession is nil)
	 */
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
