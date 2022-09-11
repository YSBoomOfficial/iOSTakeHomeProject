//
//  PeopleViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class PeopleViewModelSuccessTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var vm: PeopleViewModel!

	override func setUp() {
		super.setUp()
		networkingMock = NetworkingManagerUserResponseSuccessMock()
		vm = .init(networkingManager: networkingMock)
	}

	override func tearDown() {
		super.tearDown()
		networkingMock = nil
		vm = nil
	}

	func test_with_successful_response_users_array_is_set() async {
		XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, before fetching")
		defer {
			XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, after fetching")
			XCTAssertEqual(vm.viewState, .finished, "ViewModel's view state should be finished")
		}
		await vm.fetchUsers()
		XCTAssertEqual(vm.users.count, 6, "Should be 6 users in our users array")
	}

	func test_with_successful_paginated_response_users_array_is_set() async {
		XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, before fetching")
		defer {
			XCTAssertFalse(vm.isFetching, "ViewModel shouldn't be fetching any data, after fetching")
			XCTAssertEqual(vm.viewState, .finished, "ViewModel's view state should be finished")
		}
		await vm.fetchUsers()
		XCTAssertEqual(vm.users.count, 6, "Should be 6 users in our users array")
		await vm.fetchNextSetOfUsers()
		XCTAssertEqual(vm.users.count, 12, "Should be 12 users in our users array")
		XCTAssertEqual(vm.page, 2, "Page should be 2")
	}

	func test_with_reset_called_values_are_reset() async {
		defer {
			XCTAssertEqual(vm.users.count, 6, "Should be 6 users in our users array")
			XCTAssertEqual(vm.page, 1, "Page should be 1")
			XCTAssertEqual(vm.totalPages, 2, "Total Pages should be 2")
			XCTAssertEqual(vm.viewState, .finished, "View State should be finished")
			XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, before fetching")
		}

		await vm.fetchUsers()
		XCTAssertEqual(vm.users.count, 6, "Should be 6 users in our users array")
		await vm.fetchNextSetOfUsers()
		XCTAssertEqual(vm.users.count, 12, "Should be 12 users in our users array")
		XCTAssertEqual(vm.page, 2, "Page should be 2")

		await vm.fetchUsers() // Rest called at top of fetchUsers() 
	}

	func test_with_last_user_func_returns_true() async {
		await vm.fetchUsers()
		let staticJSON = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
		let hasReachedEnd = vm.hasReachedEnd(of: staticJSON.data.last!)

		XCTAssertTrue(hasReachedEnd, "has reached end should be true")
	}

}
