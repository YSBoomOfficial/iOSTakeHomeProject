//
//  CreateViewModelValidationFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class CreateViewModelValidationFailureTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var validationMock: CreateValidating!
	private var vm: CreateViewModel!

	override func setUp() {
		super.setUp()
		networkingMock = NetworkingManagerCreateSuccessMock()
		validationMock = CreateValidatorFailureMock()
		vm = .init(networkingManager: networkingMock, validator: validationMock)
	}

	override func tearDown() {
		super.tearDown()
		networkingMock = nil
		validationMock = nil
		vm = nil
	}

	func test_with_invalid_form_submission_state_is_invalid() async {
		XCTAssertNil(vm.state, "ViewModel's state should be nil")
		defer {
			XCTAssertEqual(vm.state, .unsuccessful, "ViewModel's state should be unsuccessful")
		}
		await vm.create()
		XCTAssertTrue(vm.hasError, "ViewModel hasError should be true")
		XCTAssertNotNil(vm.error, "ViewModel Error should not be nil")
		XCTAssertEqual(vm.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName), "ViewModel Error should be invalidFirstName")
	}
}
