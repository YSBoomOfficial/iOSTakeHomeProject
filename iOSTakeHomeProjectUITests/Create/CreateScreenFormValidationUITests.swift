//
//  CreateScreenFormValidationUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class CreateScreenFormValidationUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app = .init()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-people-networking-success": "1"]
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app = nil
	}

	func test_when_all_form_fields_are_empty_first_name_error_is_shown() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "submit button should be visible")
		submitButton.tap()

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "alert should be visible")
		XCTAssertTrue(alert.staticTexts["First Name can't be empty"].exists)

		let alertButton = alert.buttons["OK"]
		XCTAssertTrue(alertButton.exists)
		alertButton.tap()

		XCTAssertTrue(app.staticTexts["First Name can't be empty"].exists)

		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func test_when_first_name_form_field_is_empty_first_name_error_is_shown() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let lastNameTextField = app.textFields["lastNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		XCTAssertTrue(lastNameTextField.exists, "lastName textfield should be visible")
		XCTAssertTrue(jobTextField.exists, "job textfield should be visible")

		lastNameTextField.tap()
		lastNameTextField.typeText("Last Name")

		jobTextField.tap()
		jobTextField.typeText("Job")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "submit button should be visible")
		submitButton.tap()

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "alert should be visible")
		XCTAssertTrue(alert.staticTexts["First Name can't be empty"].exists)

		let alertButton = alert.buttons["OK"]
		XCTAssertTrue(alertButton.exists)
		alertButton.tap()

		XCTAssertTrue(app.staticTexts["First Name can't be empty"].exists)

		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func test_when_last_name_form_field_is_empty_last_name_error_is_shown() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let jobTextField = app.textFields["jobTextField"]

		XCTAssertTrue(firstNameTextField.exists, "firstName textfield should be visible")
		XCTAssertTrue(jobTextField.exists, "job textfield should be visible")

		firstNameTextField.tap()
		firstNameTextField.typeText("First Name")

		jobTextField.tap()
		jobTextField.typeText("Job")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "submit button should be visible")
		submitButton.tap()

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "alert should be visible")
		XCTAssertTrue(alert.staticTexts["Last Name can't be empty"].exists)

		let alertButton = alert.buttons["OK"]
		XCTAssertTrue(alertButton.exists)
		alertButton.tap()

		XCTAssertTrue(app.staticTexts["Last Name can't be empty"].exists)

		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

	func test_job_form_field_is_empty_last_job_error_is_shown() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let firstNameTextField = app.textFields["firstNameTextField"]
		let lastNameTextField = app.textFields["lastNameTextField"]

		XCTAssertTrue(firstNameTextField.exists, "firstName textfield should be visible")
		XCTAssertTrue(lastNameTextField.exists, "lastName textfield should be visible")

		firstNameTextField.tap()
		firstNameTextField.typeText("First Name")

		lastNameTextField.tap()
		lastNameTextField.typeText("Last Name")

		let submitButton = app.buttons["submitButton"]
		XCTAssertTrue(submitButton.exists, "submit button should be visible")
		submitButton.tap()

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "alert should be visible")
		XCTAssertTrue(alert.staticTexts["Job can't be empty"].exists)

		let alertButton = alert.buttons["OK"]
		XCTAssertTrue(alertButton.exists)
		alertButton.tap()

		XCTAssertTrue(app.staticTexts["Job can't be empty"].exists)

		XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
	}

}
