//
//  NetworkingManagerUserResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

final class NetworkingManagerUserResponseSuccessMock: NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
	}

	func request(session: URLSession, _ endpoint: Endpoint) async throws {}

}
