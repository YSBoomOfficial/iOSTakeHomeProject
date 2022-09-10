//
//  Endpoint.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

enum Endpoint {
	case people(page: Int)
	case detail(id: Int)
	case create(submissionData: Data?)
}

extension Endpoint {
	var host: String { "reqres.in" }

	var path: String {
		switch self {
			case .people, .create: return "/api/users"
			case .detail(let id): return "/api/users/\(id)"
		}
	}
}

extension Endpoint {
	enum MethodType {
		case GET
		case POST(data: Data?)
	}
}

extension Endpoint {
	var url: URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = host
		components.path = path

		var requestQueryItems = queryItems?.compactMap { item in
			URLQueryItem(name: item.key, value: item.value )
		}

		#if DEBUG
		requestQueryItems?.append(.init(name: "delay", value: "1"))
		#endif

		components.queryItems = requestQueryItems

		return components.url
	}

	var methodType: MethodType {
		switch self {
			case .people, .detail: return .GET
			case let .create(data): return . POST(data: data)
		}
	}

	var queryItems: [String: String]? {
		switch self {
			case .people(let page):
				return ["page": "\(page)"]
			default:
				return nil
		}
	}

}
