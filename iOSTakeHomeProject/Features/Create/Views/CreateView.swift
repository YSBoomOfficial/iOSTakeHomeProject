//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) var dismiss

	@FocusState private var focusedField: Field?
	@StateObject private var vm = CreateViewModel()
	private let successfulAction: () -> Void

	init(successfulAction: @escaping () -> Void) {
		self.successfulAction = successfulAction
#if DEBUG
		if UITestingHelper.isUITesting {
			let mock: NetworkingManaging = UITestingHelper.isCreateNetworkingSuccessful ? NetworkingManagerCreateSuccessMock() : NetworkingManagerCreateFailureMock()
			_vm = .init(wrappedValue: .init(networkingManager: mock))
		} else {
			_vm = .init(wrappedValue: .init())
		}
#else
		_vm = .init(wrappedValue: .init())
#endif
	}

	var body: some View {
		Form {
			Section {
				firstName
				lastName
				job
			} footer: {
				if case let .validation(error) = vm.error,
				   let errorDescription = error.errorDescription {
					Text(errorDescription)
						.foregroundColor(.red)
				}
			}

			Section {
				submit
			}
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) { done }
		}
		.onChange(of: vm.state) { formState in
			if formState == .successful {
				dismiss()
				successfulAction()
			}
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {}
		.overlay {
			if vm.state == .submitting {
				ProgressView("Submitting…")
			}
		}
		.disabled(vm.state == .submitting)
		.embedInNavigation(withTitle: "Create")
	}

}

extension CreateView {
	enum Field: Hashable {
		case firstName
		case lastName
		case job
	}
}

struct CreateView_Previews: PreviewProvider {
	static var previews: some View {
		CreateView {}
			.preferredColorScheme(.dark)
	}
}

private extension CreateView {
	var done: some View {
		Button("Done") { dismiss() }
			.accessibilityIdentifier("doneButton")
	}

	var firstName: some View {
		TextField("First Name", text: $vm.person.firstName)
			.focused($focusedField, equals: .firstName)
			.accessibilityIdentifier("firstNameTextField")
	}

	var lastName: some View {
		TextField("Last Name", text: $vm.person.lastName)
			.focused($focusedField, equals: .lastName)
			.accessibilityIdentifier("lastNameTextField")
	}

	var job: some View {
		TextField("Job", text: $vm.person.job)
			.focused($focusedField, equals: .job)
			.accessibilityIdentifier("jobTextField")
	}

	var submit: some View {
		Button("Submit") {
			focusedField = nil
			Task { await vm.create() }
		}
		.accessibilityIdentifier("submitButton")
	}
}
