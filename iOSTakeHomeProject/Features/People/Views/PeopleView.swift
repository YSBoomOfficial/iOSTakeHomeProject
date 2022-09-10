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

	var body: some View {
		NavigationView {
			ZStack {
				background
				ScrollView {
					LazyVGrid(columns: columns, spacing: 16) {
						ForEach(vm.users, id: \.id) { user in
							NavigationLink {
								DetailView()
							} label: {
								PersonItemView(user: user)
							}
						}
					}
					.padding()
				}
			}
			.navigationTitle("People")
			.sheet(isPresented: $shouldShowCreate) {
				CreateView()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) { create }
			}
			.onAppear { vm.fetchUsers() }
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
		}
	}
}
