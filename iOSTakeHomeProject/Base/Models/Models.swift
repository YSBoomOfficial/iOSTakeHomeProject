//
//  Models.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

// MARK: - User
struct User: Codable {
	let id: Int
	let email: String
	let firstName: String
	let lastName: String
	let avatar: String
}

// MARK: - Support
struct Support: Codable {
	let url: String
	let text: String
}

