//
//  MockURLSessionProtocol.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import Foundation
import XCTest

final class MockURLSessionProtocol: URLProtocol {
	static var loadingHandler: (()-> (HTTPURLResponse, Data?))?

	override class func canInit(with request: URLRequest) -> Bool {
		true
	}

	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		request
	}

	override func startLoading() {
		guard let handler = Self.loadingHandler else {
			XCTFail("Loading Handler not set")
			return
		}

		let (response, data) = handler()
		client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

		if let data = data {
			client?.urlProtocol(self, didLoad: data)
		}

		client?.urlProtocolDidFinishLoading(self)
	}

	override func stopLoading() {}
}
