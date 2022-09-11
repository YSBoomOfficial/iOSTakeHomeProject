//
//  NetworkingManagerCreateFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

final class NetworkingManagerCreateFailureMock: NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		return Data() as! T
	}

	func request(session: URLSession, _ endpoint: Endpoint) async throws {
		throw NetworkingManager.NetworkingError.invalidURL
	}
}
#endif
