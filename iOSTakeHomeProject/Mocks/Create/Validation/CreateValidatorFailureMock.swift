//
//  CreateValidatorFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

final class CreateValidatorFailureMock: CreateValidating {
	func validate(_ person: NewPerson) throws {
		throw CreateValidator.CreateValidatorError.invalidFirstName
	}
}
#endif
