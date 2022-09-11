//
//  CreateValidatorFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

final class CreateValidatorFailureMock: CreateValidating {
	func validate(_ person: NewPerson) throws {
		throw CreateValidator.CreateValidatorError.invalidFirstName
	}
}
