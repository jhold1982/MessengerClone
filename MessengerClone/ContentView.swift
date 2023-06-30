//
//  ContentView.swift
//  MessengerClone
//
//  Created by Justin Hold on 6/27/23.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - PROPERTIES
	
	
	
	// MARK: - BODY
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

// MARK: - PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
