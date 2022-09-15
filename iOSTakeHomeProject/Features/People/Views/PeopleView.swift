//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PeopleView: View {
	private let columns = Array(repeating: GridItem(.flexible()), count: 2)

	@StateObject private var vm: PeopleViewModel
	@State private var shouldShowCreate = false
	@State private var shouldShowSuccess = false

	@State private var hasAppeared = false

	init() {
#if DEBUG
		if UITestingHelper.isUITesting {
			let mock: NetworkingManaging = UITestingHelper.isPeopleNetworkingSuccessful ? NetworkingManagerUsersResponseSuccessMock() : NetworkingManagerUsersResponseFailureMock()
			_vm = .init(wrappedValue: .init(networkingManager: mock))
		} else {
			_vm = .init(wrappedValue: .init())
		}
#else
		_vm = .init(wrappedValue: .init())
#endif
	}

	var body: some View {
		ZStack {
			background

			if vm.isLoading {
				ProgressView("Loading…")
			} else {
				ScrollView {
					peopleGrid
				}
				.overlay(alignment: .bottom) {
					if vm.isFetching {
						ProgressView("Loading…")
					}
				}
				.refreshable {
					await vm.fetchUsers()
				}
			}
		}
		.task {
			if !hasAppeared {
				await vm.fetchUsers()
				hasAppeared = true
			}
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) { create }
			ToolbarItem(placement: .navigationBarLeading) { refresh }
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
			Button("Cancel", role: .cancel) {}

			Button("Retry") {
				Task { await vm.fetchUsers() }
			}
		}
		.overlay {
			if shouldShowSuccess {
				checkmarkPopoverView
			}
		}
		.embedInNavigation(withTitle: "People")

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
		}
		.disabled(vm.isLoading)
		.accessibilityIdentifier("createButton")
	}

	var refresh: some View {
		Button {
			Task { await vm.fetchUsers() }
		} label: {
			Symbols.refresh
				.font(
					.system(.headline, design: .rounded)
					.bold()
				)
		}.disabled(vm.isLoading)
	}
}

private extension PeopleView {
	var peopleGrid: some View {
		LazyVGrid(columns: columns, spacing: 16) {
			ForEach(vm.users, id: \.id) { user in
				NavigationLink {
					DetailView(userID: user.id)
				} label: {
					PersonItemView(user: user)
						.accessibilityIdentifier("item_\(user.id)")
						.task {
							if vm.hasReachedEnd(of: user) && !vm.isFetching {
								await vm.fetchNextSetOfUsers()
							}
						}
				}
			}
		}
		.padding()
		.accessibilityIdentifier("peopleGrid")
	}

	var checkmarkPopoverView: some View {
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
