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
		methodType: MethodType = .GET,
		_ absoluteURL: String,
		type: T.Type,
		completion: @escaping (Result<T, Error>) -> Void
	) {
		guard let url = URL(string: absoluteURL) else {
			completion(.failure(NetworkingError.invalidURL))
			return
		}

		let request = buildRequest(for: url, methodType: methodType)

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
		methodType: MethodType,
		_ absoluteURL: String,
		completion: @escaping (Result<Void, Error>) -> Void
	) {
		guard let url = URL(string: absoluteURL) else {
			completion(.failure(NetworkingError.invalidURL))
			return
		}

		let request = buildRequest(for: url, methodType: methodType)

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
	enum NetworkingError: Error {
		case invalidURL
		case custom(Error)
		case invalidStatusCode(statusCode: Int)
		case invalidData
		case failedToDecode(error: Error)
	}
}

extension NetworkingManager {
	enum MethodType {
		case GET
		case POST(data: Data?)
	}

	private func buildRequest(for url: URL, methodType: MethodType) -> URLRequest  {
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
