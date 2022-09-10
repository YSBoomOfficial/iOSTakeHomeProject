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

	func create() {

		do {
			try validator.validate(person)

			state = .submitting
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try? encoder.encode(person)

			NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users" + "?delay=3") { [weak self] result in
				DispatchQueue.main.async {
					switch result {
						case .success():
							self?.state = .successful
						case let .failure(error):
							self?.state = .unsuccessful
							self?.hasError = true
							if let error = error as? NetworkingManager.NetworkingError {
								self?.error = .networking(error: error)
							}
					}
				}
			}
		} catch {
			hasError = true
			if let validationError = error as? CreateValidator.CreateValidatorError {
				self.error = .validation(error: validationError)
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

		var errorDescription: String? {
			switch self {
				case let .networking(error), let .validation(error):
					return error.errorDescription
			}
		}
	}
}
