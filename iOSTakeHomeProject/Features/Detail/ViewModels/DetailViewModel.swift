//
//  DetailViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class DetailViewModel: ObservableObject {
	@Published private(set) var userInfo: UserDetailResponse?

	func fetchDetails(for id: Int) {
		NetworkingManager.shared.request(
			"https://reqres.in/api/users/\(id)",
			type: UserDetailResponse.self
		) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
					case let .success(response):
						self?.userInfo = response
					case let .failure(error):
						print(error)
				}
			}
		}
	}
}
