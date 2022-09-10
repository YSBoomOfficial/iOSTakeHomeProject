//
//  JSONMapperTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 10/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class JSONMapperTests: XCTestCase {

	func test_with_valid_json_successful_decoded() {
		XCTAssertNoThrow(
			try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self),
			"Mapper shouldn't throw an error"
		)

		let usersResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)

		XCTAssertNotNil(usersResponse, "usersResponse should not be nil")

		XCTAssertEqual(usersResponse!.page, 1, "Page number should be 1")
		XCTAssertEqual(usersResponse!.perPage, 6, "Per Page number should be 6")
		XCTAssertEqual(usersResponse!.total, 12, "Total should be 12")
		XCTAssertEqual(usersResponse!.totalPages, 2, "Total Pages should be 2")

		XCTAssertEqual(usersResponse!.data.count, 6, "Total number of users should be 6")

		let users = usersResponse!.data

		XCTAssertEqual(users[0].id, 1, "User's id should be 1")
		XCTAssertEqual(users[0].firstName, "George", "User's firstName should be George")
		XCTAssertEqual(users[0].lastName, "Bluth", "User's lastNam should be Bluth")
		XCTAssertEqual(users[0].email, "george.bluth@reqres.in", "User's email should be george.bluth@reqres.in")
		XCTAssertEqual(users[0].avatar, "https://reqres.in/img/faces/1-image.jpg", "User's avatar should be https://reqres.in/img/faces/1-image.jpg")

		XCTAssertEqual(users[1].id, 2, "User's id should be 2")
		XCTAssertEqual(users[1].email, "janet.weaver@reqres.in", "User's email should be janet.weaver@reqres.in")
		XCTAssertEqual(users[1].firstName, "Janet", "User's firstName should be Janet")
		XCTAssertEqual(users[1].lastName, "Weaver", "User's lastName should be Weaver")
		XCTAssertEqual(users[1].avatar, "https://reqres.in/img/faces/2-image.jpg", "User's avatar should be https://reqres.in/img/faces/2-image.jpg")

		XCTAssertEqual(users[2].id, 3, "User's id should be 3")
		XCTAssertEqual(users[2].email, "emma.wong@reqres.in", "User's email should be emma.wong@reqres.in")
		XCTAssertEqual(users[2].firstName, "Emma", "User's firstName should be Emma")
		XCTAssertEqual(users[2].lastName, "Wong", "User's lastName should be Wong")
		XCTAssertEqual(users[2].avatar, "https://reqres.in/img/faces/3-image.jpg", "User's avatar should be https://reqres.in/img/faces/3-image.jpg")

		XCTAssertEqual(users[3].id, 4, "User's id should be 4")
		XCTAssertEqual(users[3].email, "eve.holt@reqres.in", "User's email should be eve.holt@reqres.in")
		XCTAssertEqual(users[3].firstName, "Eve", "User's firstName should be Eve")
		XCTAssertEqual(users[3].lastName, "Holt", "User's lastName should be Holt")
		XCTAssertEqual(users[3].avatar, "https://reqres.in/img/faces/4-image.jpg", "User's avatar should be https://reqres.in/img/faces/4-image.jpg")

		XCTAssertEqual(users[4].id, 5, "User's id should be 5")
		XCTAssertEqual(users[4].email, "charles.morris@reqres.in", "User's email should be charles.morris@reqres.in")
		XCTAssertEqual(users[4].firstName, "Charles", "User's firstName should be Charles")
		XCTAssertEqual(users[4].lastName, "Morris", "User's lastName should be Morris")
		XCTAssertEqual(users[4].avatar, "https://reqres.in/img/faces/5-image.jpg", "User's avatar should be https://reqres.in/img/faces/5-image.jpg")

		XCTAssertEqual(users[5].id, 6, "User's id should be 6")
		XCTAssertEqual(users[5].email, "tracey.ramos@reqres.in", "User's email should be tracey.ramos@reqres.in")
		XCTAssertEqual(users[5].firstName, "Tracey", "User's firstName should be Tracey")
		XCTAssertEqual(users[5].lastName, "Ramos", "User's lastName should be Ramos")
		XCTAssertEqual(users[5].avatar, "https://reqres.in/img/faces/6-image.jpg", "User's avatar should be https://reqres.in/img/faces/6-image.jpg")

	}

	func test_with_file_name_empty_error_thrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "Mapper should throw custom error")

		do {
			_ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("Wrong Mapping error")
				return
			}

			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failedToGetContents error")
		}
	}

	func test_with_invalid_file_name_error_thrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "WrongFileName", type: UsersResponse.self), "Mapper should throw custom error")

		do {
			_ = try StaticJSONMapper.decode(file: "WrongFileName", type: UsersResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("Wrong Mapping error")
				return
			}

			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failedToGetContents error")
		}
	}

	func test_with_invalid_json_error_thrown() {
		XCTAssertThrowsError(
			try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self),
			"Mapper should throw an error"
		)

		do {
			_ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
		} catch {
			if error is StaticJSONMapper.MappingError {
				XCTFail("Wrong type of error thrown, should not be MappingError")
			}
		}
	}

}

