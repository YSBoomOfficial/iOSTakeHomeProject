//
//  PeopleViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class PeopleViewModel: ObservableObject {
	@Published private(set) var users = [User]()

	func fetchUsers() {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users",
			type: UsersResponse.self
		) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
					case let .success(response):
						self?.users = response.data
					case let .failure(error):
						print(error)
				}
			}
		}
	}
}
