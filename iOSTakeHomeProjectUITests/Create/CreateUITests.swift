//
//  CreateUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class CreateUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app = .init()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = [
			"-people-networking-success": "1",
			"-create-networking-success": "1"
		]
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app = nil
	}

	func test_valid_form_submission_is_successful() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let lastNameTextField = app.textFields["lastNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		XCTAssertTrue(firstNameTextField.exists, "firstName textfield should be visible")
		XCTAssertTrue(lastNameTextField.exists, "lastName textfield should be visible")
		XCTAssertTrue(jobTextField.exists, "jobTextField textfield should be visible")

		firstNameTextField.tap()
		firstNameTextField.typeText("First Name")

		lastNameTextField.tap()
		lastNameTextField.typeText("Last Name")

		jobTextField.tap()
		jobTextField.typeText("Job")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "submit button should be visible")
		submitButton.tap()

		XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "People nav title should be visible")
	}

}
