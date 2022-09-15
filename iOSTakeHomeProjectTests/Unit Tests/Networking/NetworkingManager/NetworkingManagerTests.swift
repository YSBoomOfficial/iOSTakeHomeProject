//
//  NetworkingManagerTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class NetworkingManagerTests: XCTestCase {
	private var session: URLSession!
	private var url: URL!

	override func setUp() {
		super.setUp()
		url = URL(string: "https://reqres.in/api/users")
		let config = URLSessionConfiguration.ephemeral
		config.protocolClasses = [MockURLSessionProtocol.self]
		session = .init(configuration: config)
	}

	override func tearDown() {
		super.tearDown()
		url = nil
		session = nil
	}

	func test_with_successful_response_response_is_valid() async throws {
		guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
			  let data = FileManager.default.contents(atPath: path) else {
			XCTFail("file UsersStaticData.json not found")
			return
		}

		MockURLSessionProtocol.loadingHandler = {
			let response = HTTPURLResponse(
				url: self.url,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)

			return (response!, data)
		}

		let result = try await NetworkingManager.shared.request(
			session: session,
			.people(page: 1),
			type: UsersResponse.self
		)

		let staticJSON = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
		
		XCTAssertEqual(result, staticJSON, "result and staticJSON should be the same")
	}

	func test_with_successful_response_void_is_valid() async throws {
		MockURLSessionProtocol.loadingHandler = {
			let response = HTTPURLResponse(
				url: self.url,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)

			return (response!, nil)
		}

		_ = try await NetworkingManager.shared.request(
			session: session,
			.people(page: 1)
		)
	}

	func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
		let invalidStatusCode = 400

		MockURLSessionProtocol.loadingHandler = {
			let response = HTTPURLResponse(
				url: self.url,
				statusCode: invalidStatusCode ,
				httpVersion: nil,
				headerFields: nil
			)

			return (response!, nil)
		}

		do {
			_ = try await NetworkingManager.shared.request(
				session: session,
				.people(page: 1),
				type: UsersResponse.self
			)
		} catch {
			guard let networkingError = error as? NetworkingManager.NetworkingError else {
				XCTFail("Wrong type of error, should be NetworkingError")
				return
			}

			XCTAssertEqual(networkingError, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode), "Should be invalid status code")
		}
	}

	func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
		let invalidStatusCode = 400

		MockURLSessionProtocol.loadingHandler = {
			let response = HTTPURLResponse(
				url: self.url,
				statusCode: invalidStatusCode ,
				httpVersion: nil,
				headerFields: nil
			)

			return (response!, nil)
		}

		do {
			_ = try await NetworkingManager.shared.request(
				session: session,
				.people(page: 1)
			)
		} catch {
			guard let networkingError = error as? NetworkingManager.NetworkingError else {
				XCTFail("Wrong type of error, should be NetworkingError")
				return
			}

			XCTAssertEqual(networkingError, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode), "Should be invalid status code")
		}
	}

	func test_with_successful_response_with_invalid_json_is_invalid() async {
		guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
			  let data = FileManager.default.contents(atPath: path) else {
			XCTFail("file UsersStaticData.json not found")
			return
		}

		MockURLSessionProtocol.loadingHandler = {
			let response = HTTPURLResponse(
				url: self.url,
				statusCode: 200,
				httpVersion: nil,
				headerFields: nil
			)

			return (response!, data)
		}

		do {
			_ = try await NetworkingManager.shared.request(
				session: session,
				.people(page: 1),
				type: UserDetailResponse.self
			)
		} catch {
			if error is NetworkingManager.NetworkingError {
				XCTFail("Wrong type of error, should be system decoding error")
				return
			}
		}


	}

}
