//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//
#if DEBUG
import Foundation

final class CreateValidatorSuccessMock: CreateValidating {
	func validate(_ person: NewPerson) throws {}
}
#endif
