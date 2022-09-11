//
//  NetworkingManagerUserDetailResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

final class NetworkingManagerUserDetailResponseSuccessMock: NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
	}

	func request(session: URLSession, _ endpoint: Endpoint) async throws {}

}
