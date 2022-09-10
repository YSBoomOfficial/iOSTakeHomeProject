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

	func request<T: Decodable>(
		_ endpoint: Endpoint,
		type: T.Type,
		completion: @escaping (Result<T, Error>) -> Void
	) {
		guard let url = endpoint.url else {
			completion(.failure(NetworkingError.invalidURL))
			return
		}

		let request = buildRequest(from: url, methodType: endpoint.methodType)

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(NetworkingError.custom(error)))
				return
			}

			guard let response = response as? HTTPURLResponse,
				  (200...300) ~= response.statusCode else {
				let statusCode = (response as! HTTPURLResponse).statusCode
				completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
				return
			}

			guard let data = data else {
				completion(.failure(NetworkingError.invalidData))
				return
			}

			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let res = try decoder.decode(T.self, from: data)
				completion(.success(res))
			} catch {
				completion(.failure(NetworkingError.failedToDecode(error: error)))
			}
		}.resume()
	}

	func request(
		_ endpoint: Endpoint,
		completion: @escaping (Result<Void, Error>) -> Void
	) {
		guard let url = endpoint.url else {
			completion(.failure(NetworkingError.invalidURL))
			return
		}

		let request = buildRequest(from: url, methodType: endpoint.methodType)

		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(NetworkingError.custom(error)))
				return
			}

			guard let response = response as? HTTPURLResponse,
				  (200...300) ~= response.statusCode else {
				let statusCode = (response as! HTTPURLResponse).statusCode
				completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
				return
			}

			completion(.success(()))
		}.resume()
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
