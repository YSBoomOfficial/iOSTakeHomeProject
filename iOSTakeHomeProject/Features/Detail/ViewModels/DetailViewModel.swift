//
//  DetailViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class DetailViewModel: ObservableObject {
	private let networkingManager: NetworkingManaging
	
	@Published private(set) var userInfo: UserDetailResponse?
	@Published private(set) var isLoading = false
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false

	init(networkingManager: NetworkingManaging = NetworkingManager.shared) {
		self.networkingManager = networkingManager
	}

	@MainActor
	func fetchDetails(for id: Int) async {
		isLoading = true
		defer { isLoading = false }

		do {
			userInfo = try await networkingManager.request(
				session: .shared,
				.detail(id: id),
				type: UserDetailResponse.self
			)
		} catch {
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error)
			}
		}
	}
}
