//
//  CreateFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class CreateFailureUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app = .init()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = [
			"-people-networking-success": "1",
			"-create-networking-success": "0"
		]
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app = nil
	}

	func test_alert_is_shown_when_submission_fails() {
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

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "alert should be visible")
		XCTAssertTrue(alert.staticTexts["The URL is invalid."].exists)

		let alertButton = alert.buttons["OK"]
		XCTAssertTrue(alertButton.exists)
		alertButton.tap()

		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

}
