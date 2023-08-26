//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 7/7/23.
//

import Foundation
import SwiftUI
import PhotosUI

// MARK: - CLASS BODY
class ProfileViewModel: ObservableObject {
	
	
	// MARK: - PROPERTIES
	@Published var selectedItem: PhotosPickerItem? {
		didSet {
			Task {
				try await loadImage()
			}
		}
	}
	@Published var profileImage: Image?
	
	// MARK: - FUNCTIONS
	func loadImage() async throws {
		guard let item = selectedItem else { return }
		guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
		guard let uiImage = UIImage(data: imageData) else { return }
		self.profileImage = Image(uiImage: uiImage)
	}
}
