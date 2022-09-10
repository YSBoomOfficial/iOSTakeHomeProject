//
//  NetworkingManager.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class NetworkingManager {
	static let shared = NetworkingManager()

	private init() {}

	func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
		guard let url = endpoint.url else { throw NetworkingError.invalidURL }

		let request = buildRequest(from: url, methodType: endpoint.methodType)
 
		let (data, response) = try await URLSession.shared.data(for: request)

		guard let response = response as? HTTPURLResponse,
			  (200...300) ~= response.statusCode else {
			let statusCode = (response as! HTTPURLResponse).statusCode
			throw NetworkingError.invalidStatusCode(statusCode: statusCode)
		}

		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			return try decoder.decode(T.self, from: data)
		} catch {
			throw NetworkingError.failedToDecode(error: error)
		}
	}

	func request(_ endpoint: Endpoint) async throws {
		guard let url = endpoint.url else { throw NetworkingError.invalidURL }

		let request = buildRequest(from: url, methodType: endpoint.methodType)

		let (_, response) = try await URLSession.shared.data(for: request)

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
