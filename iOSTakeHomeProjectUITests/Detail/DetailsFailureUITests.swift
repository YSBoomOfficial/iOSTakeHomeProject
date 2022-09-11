//
//  DetailsFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by Yash Shah on 11/09/2022.
//

import XCTest

class DetailsFailureUITests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false

		app = .init()
		app.launchArguments = ["-ui-testing"]
		app.launchEnvironment = [
			"-people-networking-success": "1",
			"-details-networking-success": "0"
		]
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app = nil
	}

	func test_alert_is_shown_when_screen_fails_to_load() {
		let grid = app.otherElements["peopleGrid"]
		XCTAssertTrue(grid.waitForExistence(timeout: 5), "the people grid should be visible")

		let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
		let gridItems = grid.buttons.containing(predicate)
		gridItems.firstMatch.tap()

		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.waitForExistence(timeout: 5), "Alert Should be shown")
		XCTAssertTrue(alert.staticTexts["The URL is invalid."].exists, "Alert Message is invalid")

		let okButton = alert.buttons["OK"]
		XCTAssertTrue(okButton.exists, "Alert Should show OK button")
		okButton.tap()

		XCTAssertTrue(app.staticTexts["Details"].exists)
		XCTAssertTrue(app.staticTexts["#0"].exists)
		XCTAssertTrue(app.staticTexts["First Name"].exists)
		XCTAssertTrue(app.staticTexts["Last Name"].exists)
		XCTAssertTrue(app.staticTexts["Email"].exists)

		let textPlaceHolderPredicate = NSPredicate(format: "label CONTAINS '-'")
		let placeholderItems = app.staticTexts.containing(textPlaceHolderPredicate)
		XCTAssertEqual(placeholderItems.count, 3, "There should be 3 placeholder on screen")
	}

}
