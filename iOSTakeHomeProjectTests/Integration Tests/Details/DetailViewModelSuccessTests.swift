//
//  DetailViewModelSuccessTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class DetailViewModelSuccessTests: XCTestCase {
	private var networkingMock: NetworkingManaging!
	private var vm: DetailViewModel!

	override func setUp() {
		super.setUp()
		networkingMock = NetworkingManagerUserDetailResponseSuccessMock()
		vm = .init(networkingManager: networkingMock)
	}

	override func tearDown() {
		super.tearDown()
		networkingMock = nil
		vm = nil
	}

	func test_with_successful_response_user_detail_is_set() async {
		XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, before fetching")
		defer {
			XCTAssertFalse(vm.isLoading, "ViewModel shouldn't be loading any data, after fetching")
		}
		await vm.fetchDetails(for: 1)

		XCTAssertNotNil(vm.userInfo, "ViewModel User info shouldn't be nil")

		let userDetails = try! StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)

		XCTAssertEqual(vm.userInfo!, userDetails, "User Detail response from networking response should match")

	}

}
