//
//  NetworkingManager.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

protocol NetworkingManaging {
	func request<T: Decodable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T

	func request(session: URLSession, _ endpoint: Endpoint) async throws
}

final class NetworkingManager: NetworkingManaging {
	static let shared = NetworkingManager()

	private init() {}

	func request<T: Decodable>(session: URLSession = .shared, _ endpoint: Endpoint, type: T.Type) async throws -> T {
		guard let url = endpoint.url else { throw NetworkingError.invalidURL }

		let request = buildRequest(from: url, methodType: endpoint.methodType)
 
		let (data, response) = try await session.data(for: request)

		guard let response = response as? HTTPURLResponse,
			  (200...300) ~= response.statusCode else {
			let statusCode = (response as! HTTPURLResponse).statusCode
			throw NetworkingError.invalidStatusCode(statusCode: statusCode)
		}

		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return try decoder.decode(T.self, from: data)
	}

	func request(session: URLSession = .shared, _ endpoint: Endpoint) async throws {
		guard let url = endpoint.url else { throw NetworkingError.invalidURL }

		let request = buildRequest(from: url, methodType: endpoint.methodType)

		let (_, response) = try await session.data(for: request)

		guard let response = response as? HTTPURLResponse,
			  (200...300) ~= response.statusCode else {
			let statusCode = (response as! HTTPURLResponse).statusCode
			throw NetworkingError.invalidStatusCode(statusCode: statusCode)
		}
	}

}

extension NetworkingManager {
	enum NetworkingError: LocalizedError {
		case invalidURL
		case custom(Error)
		case invalidStatusCode(statusCode: Int)
		case invalidData
		case failedToDecode(error: Error)

		var errorDescription: String? {
			switch self {
				case .invalidURL: return "The URL is invalid."
				case .invalidStatusCode(let statusCode): return "The status code was invalid. \(statusCode)"
				case .invalidData: return "The response data was invalid."
				case .failedToDecode(let error): return "Could not decode response. \(error.localizedDescription)"
				case .custom(let error): return "Something went wrong. \(error.localizedDescription)."
			}
		}
	}
}

extension NetworkingManager.NetworkingError: Equatable {
	static func ==(lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
		switch (lhs, rhs) {
			case (.invalidURL, .invalidURL), (.invalidData, .invalidData): return true
			case (.invalidStatusCode(let lhsCode), .invalidStatusCode(let rhsCode)):
				return lhsCode == rhsCode
			case (.custom(let lhsError), .custom(let rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			case (.failedToDecode(let lhsError), .failedToDecode(let rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			default: return false
		}
	}
}

extension NetworkingManager {
	private func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest  {
		var request = URLRequest(url: url)
		switch methodType {
			case .GET:
				request.httpMethod = "GET"
			case .POST(let data):
				request.httpMethod = "POST"
				request.httpBody = data
		}
		return request
	}
}
