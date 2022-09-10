//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PeopleView: View {
	private let columns = Array(repeating: GridItem(.flexible()), count: 2)

	@StateObject private var vm = PeopleViewModel()
	@State private var shouldShowCreate = false
	@State private var shouldShowSuccess = false

	var body: some View {
		NavigationView {
			ZStack {
				background

				if vm.isLoading {
					ProgressView("Loading…")
				} else {
					ScrollView {
						LazyVGrid(columns: columns, spacing: 16) {
							ForEach(vm.users, id: \.id) { user in
								NavigationLink {
									DetailView(userID: user.id)
								} label: {
									PersonItemView(user: user)
								}
							}
						}
						.padding()
					}
				}
			}
			.navigationTitle("People")
			.task {
				await vm.fetchUsers()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) { create }
			}
			.sheet(isPresented: $shouldShowCreate) {
				CreateView {
					haptic(.success)
					withAnimation(.spring().delay(0.25)) {
						shouldShowSuccess = true
					}
				}
			}
			.alert(isPresented: $vm.hasError, error: vm.error) {
				Button("Retry") {
					Task { await vm.fetchUsers() }
				}
			}
			.overlay {
				if shouldShowSuccess {
					CheckmarkPopoverView()
						.transition(.scale.combined(with: .opacity))
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
								withAnimation(.spring()) {
									shouldShowSuccess = false
								}
							}
						}
				}
			}
		}
	}
}

struct PeopleView_Previews: PreviewProvider {
	static var previews: some View {
		PeopleView()
			.preferredColorScheme(.dark)
	}
}

private extension PeopleView {
	var background: some View {
		Theme.background.ignoresSafeArea()
	}

	var create: some View {
		Button {
			shouldShowCreate.toggle()
		} label: {
			Symbols.plus
				.font(
					.system(.headline, design: .rounded)
					.bold()
				)
		}.disabled(vm.isLoading)
	}
}
