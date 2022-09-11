//
//  NetworkingEndpointTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class NetworkingEndpointTests: XCTestCase {

	func test_with_people_endpoint_request_is_valid() {
		let endpoint = Endpoint.people(page: 1)
		XCTAssertEqual(endpoint.host, "reqres.in", "Host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users", "Path should be /api/users")
		XCTAssertEqual(endpoint.methodType, .GET, "Method Type should be GET")
		XCTAssertEqual(endpoint.queryItems, ["page":"1"], "QueryItems should be [\"page\":\"1\"]")

		#if DEBUG
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=1", "URL should be https://reqres.in/api/users?page=1")
		#else
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1", "URL should be https://reqres.in/api/users/page=1")
		#endif
	}

	func test_with_detail_endpoint_request_is_valid() {
		let endpoint = Endpoint.detail(id: 1)
		XCTAssertEqual(endpoint.host, "reqres.in", "Host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users/1", "Path should be /api/users/1")
		XCTAssertEqual(endpoint.methodType, .GET, "Method Type should be GET")
		XCTAssertNil(endpoint.queryItems, "QueryItems should be nil")

		#if DEBUG
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/1?delay=1", "URL should be https://reqres.in/api/users/1?delay=1")
		#else
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/1", "URL should be https://reqres.in/api/users/1")
		#endif
	}

	func test_with_create_endpoint_request_is_valid() {
		let endpoint = Endpoint.create(submissionData: nil)
		XCTAssertEqual(endpoint.host, "reqres.in", "Host should be reqres.in")
		XCTAssertEqual(endpoint.path, "/api/users", "Path should be /api/users/1")
		XCTAssertEqual(endpoint.methodType, .POST(data: nil), "Method Type should be GET")
		XCTAssertNil(endpoint.queryItems, "QueryItems should be nil")

		#if DEBUG
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=1", "URL should be https://reqres.in/api/users?delay=1")
		#else
		XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users", "URL should be https://reqres.in/api/users")
	 #endif
	}
}
