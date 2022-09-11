//
//  DetailViewModelFailureTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class DetailViewModelFailureTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var vm: DetailViewModel!

	override func setUp() {
		super.setUp()
		networkingMock =  NetworkingManagerUserDetailResponseFailureMock()
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
		}
		await vm.fetchDetails(for: 1)

		XCTAssertTrue(vm.hasError, "ViewModel hasError should be true")
		XCTAssertNotNil(vm.error, "ViewModel Error should not be nil")

	}


}
