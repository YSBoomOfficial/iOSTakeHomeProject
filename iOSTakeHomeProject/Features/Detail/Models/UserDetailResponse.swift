//
//  UserDetailResponse.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//


import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
	let data: User
	let support: Support
}
