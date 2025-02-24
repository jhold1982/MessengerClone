//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/7/23.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
	
	@Published var selectedItem: PhotosPickerItem? {
		
		didSet {
			Task {
				try await loadImage()
			}
		}
	}
	
	@Published var profileImage: Image?
	
	func loadImage() async throws {
		guard let item = selectedItem else { return }
		guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
		guard let uiImage = UIImage(data: imageData) else { return }
		self.profileImage = Image(uiImage: uiImage)
	}
}

/*
 This code defines a SwiftUI view model for handling profile image selection using the PhotosPicker API. Let me break it down:

 1. `ProfileViewModel` is a class that conforms to `ObservableObject`, which allows SwiftUI views to observe and react to changes in its properties.

 2. `@Published var selectedItem: PhotosPickerItem?` is a property that holds the photo item selected by the user from their photo library. The `@Published` property wrapper makes SwiftUI aware of changes to this property.

 3. `didSet` is a property observer that triggers when `selectedItem` changes. It initiates an asynchronous task to load the selected image.

 4. `@Published var profileImage: Image?` holds the actual SwiftUI Image after it's been loaded and processed.

 5. `func loadImage() async throws` is an asynchronous function that:
	- Checks if `selectedItem` exists. If not, it returns early.
	- Tries to load the image data from the selected item.
	- Converts the data to a UIImage.
	- Converts the UIImage to a SwiftUI Image and assigns it to `profileImage`.

 This code follows a common pattern in SwiftUI applications where:
 - A view model handles data loading and processing
 - SwiftUI views observe the view model for changes
 - Asynchronous operations (loading images) are handled with Swift's async/await pattern

 This would be used in a SwiftUI view that allows users to select and display a profile picture from their photo library.

 Would you like me to explain any specific part in more detail?
 
 */
