//
//  NetworkingManagerUserDetailResponseFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

final class NetworkingManagerUserDetailResponseFailureMock: NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		throw NetworkingManager.NetworkingError.invalidURL
	}

	func request(session: URLSession, _ endpoint: Endpoint) async throws {}

}
#endif
