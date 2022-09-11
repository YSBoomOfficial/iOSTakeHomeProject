//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class PeopleViewModel: ObservableObject {
	private let networkingManager: NetworkingManaging
	
	@Published private(set) var users = [User]()
	@Published private(set) var viewState: ViewState?
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false

	private(set) var page = 1
	private(set) var totalPages: Int?

	var isLoading: Bool {
		viewState == .loading
	}

	var isFetching: Bool {
		viewState == .fetching
	}

	init(networkingManager: NetworkingManaging = NetworkingManager.shared) {
		self.networkingManager = networkingManager
	}

	@MainActor
	func fetchUsers() async {
		reset()

		viewState = .fetching
		defer { viewState = .finished }

		do {
			let response = try await networkingManager.request(
				session: .shared,
				.people(page: 1),
				type: UsersResponse.self
			)
			users = response.data
			totalPages = response.totalPages
		} catch {
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error)
			}
		}
	}

	@MainActor
	func fetchNextSetOfUsers() async {
		guard page != totalPages else { return }

		viewState = .fetching
		defer { viewState = .finished }
		
		page += 1

		do {
			let response = try await networkingManager.request(
				session: .shared,
				.people(page: page),
				type: UsersResponse.self
			)
			users += response.data
			totalPages = response.totalPages
		} catch {
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error)
			}
		}
	}

	func hasReachedEnd(of user: User) -> Bool {
		return users.last?.id == user.id
	}
}

extension PeopleViewModel {
	enum ViewState {
		case fetching
		case loading
		case finished
	}
}

private extension PeopleViewModel {
	func reset() {
		if viewState == .finished {
			users.removeAll()
			page = 1
			viewState = .loading
			totalPages = nil
		}
	}
}
