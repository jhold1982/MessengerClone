//
//  ContentViewModel.swift
//  MessengerClone
//
//  Created by Justin Hold on 8/26/23.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
	
	@Published var userSession: FirebaseAuth.User?
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		setupSubscribers()
	}
	
	private func setupSubscribers() {
		AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
			DispatchQueue.main.async {
				self?.userSession = userSessionFromAuthService
			}
		}.store(in: &cancellables)
	}
}
