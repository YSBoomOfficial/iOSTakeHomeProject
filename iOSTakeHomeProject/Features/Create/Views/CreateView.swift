//
//  CreateView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct CreateView: View {
	@Environment(\.dismiss) var dismiss

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
		}
	}
}

struct CreateView_Previews: PreviewProvider {
	static var previews: some View {
		CreateView()
			.preferredColorScheme(.dark)
	}
}

private extension CreateView {

	var done: some View {
		Button("Done") { dismiss() }
	}

	var firstName: some View {
		TextField("First Name", text: .constant(""))
	}

	var lastName: some View {
		TextField("Last Name", text: .constant(""))
	}

	var job: some View {
		TextField("Job", text: .constant(""))
	}

	var submit: some View {
		Button("Submit") {
			// Form Validation and Submission
			
			dismiss()
		}
	}
}
