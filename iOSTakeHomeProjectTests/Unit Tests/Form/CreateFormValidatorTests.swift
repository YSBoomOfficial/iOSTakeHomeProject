//
//  CreateFormValidatorTests.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest
@testable import iOSTakeHomeProject

class CreateFormValidatorTests: XCTestCase {
	private var validator: CreateValidator!

	override func setUp() {
		super.setUp()
		validator = .init()
	}

	override func tearDown() {
		super.tearDown()
		validator = nil
	}

	func test_with_empty_person_first_name_error_thrown() {
		let person = NewPerson()
		XCTAssertThrowsError(try validator.validate(person), "Error for empty first name should be thrown")

		do {
			try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Wrong type of error thrown, should be CreateValidatorError")
				return
			}
			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Should be Invalid First Name error")
		}
	}

	func test_with_empty_first_name_error_thrown() {
		let person = NewPerson(firstName: "", lastName: "Last Name", job: "Job")

		XCTAssertThrowsError(try validator.validate(person), "Error for empty first name should be thrown")

		do {
			try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Wrong type of error thrown, should be CreateValidatorError")
				return
			}
			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Should be Invalid First Name error")
		}
	}

	func test_with_empty_last_name_error_thrown() {
		let person = NewPerson(firstName: "First Name", lastName: "", job: "Job")

		XCTAssertThrowsError(try validator.validate(person), "Error for empty last name should be thrown")

		do {
			try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Wrong type of error thrown, should be CreateValidatorError")
				return
			}
			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Should be Invalid Last Name error")
		}
	}

	func test_with_empty_job_error_thrown() {
		let person = NewPerson(firstName: "First Name", lastName: "Last Name", job: "")

		XCTAssertThrowsError(try validator.validate(person), "Error for empty job should be thrown")

		do {
			try validator.validate(person)
		} catch {
			guard let validationError = error as? CreateValidator.CreateValidatorError else {
				XCTFail("Wrong type of error thrown, should be CreateValidatorError")
				return
			}
			XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Should be Invalid Job error")
		}
	}

	func test_with_valid_person_no_error_thrown() {
		let person = NewPerson(firstName: "First Name", lastName: "Last Name", job: "Job")
		XCTAssertNoThrow(try validator.validate(person), "No Error Should be thrown as the person is valid")
	}

}
