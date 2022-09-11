//
//  CreateScreenUIValidTests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class CreateScreenUIValidTests: XCTestCase {
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

	func test_when_create_is_tapped_create_view_is_presented() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		XCTAssertTrue(app.navigationBars["Create"].waitForExistence(timeout: 5), "Create nav title should be visible")
		XCTAssertTrue(app.buttons["doneButton"].exists, "done button should be visible")
		XCTAssertTrue(app.textFields["firstNameTextField"].exists, "firstName textfield should be visible")
		XCTAssertTrue(app.textFields["lastNameTextField"].exists, "lastName textfield should be visible")
		XCTAssertTrue(app.textFields["jobTextField"].exists, "job textfield should be visible")
		XCTAssertTrue(app.buttons["submitButton"].exists, "submit button should be visible")
	}

	func test_when_done_is_tapped_create_view_is_dismissed() {
		let createButton = app.buttons["createButton"]
		XCTAssertTrue(createButton.waitForExistence(timeout: 5), "the create button should be visible")
		createButton.tap()

		let doneButton = app.buttons["doneButton"]
		XCTAssertTrue(doneButton.exists, "the create button should be visible")
		doneButton.tap()

		XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "People nav title should be visible")
	}

}
