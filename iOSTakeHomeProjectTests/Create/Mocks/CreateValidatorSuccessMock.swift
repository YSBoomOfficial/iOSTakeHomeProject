//
//  CreateValidatorSuccessMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Yash Shah on 11/09/2022.
//

import Foundation
@testable import iOSTakeHomeProject

final class CreateValidatorSuccessMock: CreateValidating {
	func validate(_ person: NewPerson) throws {}
}
