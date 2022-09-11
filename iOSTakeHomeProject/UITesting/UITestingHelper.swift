//
//  UITestingHelper.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

struct UITestingHelper {

	static var isUITesting: Bool {
		ProcessInfo.processInfo.arguments.contains("-ui-testing")
	}

	static var networkingSuccessful: Bool {
		ProcessInfo.processInfo.environment["-networking-success"] == "1"
	}

}
#endif
