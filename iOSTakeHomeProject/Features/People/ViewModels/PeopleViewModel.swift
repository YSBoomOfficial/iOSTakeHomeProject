//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class PeopleViewModel: ObservableObject {
	@Published private(set) var users = [User]()
	@Published private(set) var isLoading = false
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false

	func fetchUsers() {
		isLoading = true
		NetworkingManager.shared.request(
			"https://reqres.in/api/users" + "?delay=3",
			type: UsersResponse.self
		) { [weak self] result in
			DispatchQueue.main.async {
				defer { self?.isLoading = false }
				switch result {
					case let .success(response):
						self?.users = response.data
					case let .failure(error):
						self?.hasError = true
						self?.error = error as? NetworkingManager.NetworkingError
				}
			}
		}
	}
}
