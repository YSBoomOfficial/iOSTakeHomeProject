//
//  PeopleFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class PeopleFailureUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app = .init()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = ["-people-networking-success": "0"]
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app = nil
	}

	func test_alert_is_shown_when_screen_fails_to_loads() {
		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "Alert Should be shown")
		XCTAssertTrue(alert.staticTexts["The URL is invalid."].exists, "Alert Message is invalid")
		XCTAssertTrue(alert.buttons["Cancel"].exists, "Alert Should show cancel button")
		XCTAssertTrue(alert.buttons["Retry"].exists, "Alert Should show Retry button")
	}

}
