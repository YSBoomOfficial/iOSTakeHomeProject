//
//  NetworkingManagerUsersResponseSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

final class NetworkingManagerUsersResponseSuccessMock: NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
	}

	func request(session: URLSession, _ endpoint: Endpoint) async throws {}

}
#endif
