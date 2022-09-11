//
//  PeopleViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class PeopleViewModelFailureTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var vm: PeopleViewModel!

	override func setUp() {
		super.setUp()
		networkingMock = NetworkingManagerUserResponseFailureMock()
		vm = .init(networkingManager: networkingMock)
	}

	override func tearDown() {
		super.tearDown()
		networkingMock = nil
		vm = nil
	}

	func test_with_unsuccessful_response_error_is_handled() async {
		XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, before fetching")
		defer {
			XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, after fetching")
			XCTAssertEqual(vm.viewState, .finished, "ViewModel's view state should be finished")
		}
		await vm.fetchUsers()
		XCTAssertTrue(vm.hasError, "View Model hasError should be true")
		XCTAssertNotNil(vm.error, "View Model Error should not be nil")
	}
}
