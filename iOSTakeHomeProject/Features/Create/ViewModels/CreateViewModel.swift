//
//  CreateViewModel.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import Foundation

final class CreateViewModel: ObservableObject {
	@Published var person = NewPerson()
	@Published private(set) var state: SubmissionState?
	@Published private(set) var error: FormError?
	@Published var hasError = false

	private let validator = CreateValidator()

	@MainActor
	func create() async {
		do {
			try validator.validate(person)

			state = .submitting

			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try? encoder.encode(person)

			try await NetworkingManager.shared.request(.create(submissionData: data))
			self.state = .successful
		} catch {
			hasError = true
			self.state = .unsuccessful
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = .networking(error: networkingError)
			} else if let validationError = error as? CreateValidator.CreateValidatorError {
				self.error = .validation(error: validationError)
			} else {
				self.error = .system(error: error)
			}
		}
	}
}

extension CreateViewModel {
	enum SubmissionState {
		case submitting
		case successful
		case unsuccessful
	}
}

extension CreateViewModel {
	enum FormError: LocalizedError {
		case networking(error: LocalizedError)
		case validation(error: LocalizedError)
		case system(error: Error)

		var errorDescription: String? {
			switch self {
				case let .networking(error), let .validation(error):
					return error.errorDescription
				case let .system(error):
					return error.localizedDescription
			}
		}
	}
}
