//
//  UsersResponse.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
	let page: Int
	let perPage: Int
	let total: Int
	let totalPages: Int
	let data: [User]
	let support: Support
}
