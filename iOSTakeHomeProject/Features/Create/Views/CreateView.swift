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
	let successfulAction: () -> Void

	var body: some View {
		NavigationView {
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
			.navigationTitle("Create")
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
				if vm.state == .submitting { ProgressView("Submitting…") }
			}
			.disabled(vm.state == .submitting)
		}
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
	}

	var firstName: some View {
		TextField("First Name", text: $vm.person.firstName)
			.focused($focusedField, equals: .firstName)
	}

	var lastName: some View {
		TextField("Last Name", text: $vm.person.lastName)
			.focused($focusedField, equals: .lastName)
	}

	var job: some View {
		TextField("Job", text: $vm.person.job)
			.focused($focusedField, equals: .job)
	}

	var submit: some View {
		Button("Submit") {
			focusedField = nil
			Task { await vm.create() }
		}
	}
}
