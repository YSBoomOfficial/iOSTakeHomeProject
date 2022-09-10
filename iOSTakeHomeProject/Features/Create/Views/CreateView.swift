//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) var dismiss

	@StateObject private var vm = CreateViewModel()
	let successfulAction: () -> Void


	var body: some View {
		NavigationView {
			Form {
				firstName
				lastName
				job

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

struct CreateView_Previews: PreviewProvider {
	static var previews: some View {
		CreateView {

		}
		.preferredColorScheme(.dark)
	}
}

private extension CreateView {
	var done: some View {
		Button("Done") { dismiss() }
	}

	var firstName: some View {
		TextField("First Name", text: $vm.person.firstName)
	}

	var lastName: some View {
		TextField("Last Name", text: $vm.person.lastName)
	}

	var job: some View {
		TextField("Job", text: $vm.person.job)
	}

	var submit: some View {
		Button("Submit") { vm.create() }
	}
}
