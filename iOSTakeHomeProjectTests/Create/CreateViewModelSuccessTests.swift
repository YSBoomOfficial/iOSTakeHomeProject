//
//  CreateViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class CreateViewModelSuccessTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var validationMock: CreateValidating!
	private var vm: CreateViewModel!

	override func setUp() {
		super.setUp()
		networkingMock = NetworkingManagerCreateSuccessMock()
		validationMock = CreateValidatorSuccessMock()
		vm = .init(networkingManager: networkingMock, validator: validationMock)
	}

	override func tearDown() {
		super.tearDown()
		networkingMock = nil
		validationMock = nil
		vm = nil
	}

	func test_with_successful_response_submission_state_is_successful() async throws {
		XCTAssertNil(vm.state, "ViewModel's state should be nil")
		defer { XCTAssertEqual(vm.state, .successful, "ViewModel's state should be successful") }
		await vm.create()
	}
}
