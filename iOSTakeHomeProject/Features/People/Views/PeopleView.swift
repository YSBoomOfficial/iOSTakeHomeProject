//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PeopleView: View {
	private let columns = Array(repeating: GridItem(.flexible()), count: 2)

	@State private var users = [User]()

	var body: some View {
		NavigationView {
			ZStack {
				background
				ScrollView {
					LazyVGrid(columns: columns, spacing: 16) {
						ForEach(users, id: \.id) { user in
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
			.toolbar {
				ToolbarItem(placement: .primaryAction) { create }
			}
			.onAppear {
				do {
					users = try StaticJSONMapper.decode(
						file: "UsersStaticData",
						type: UsersResponse.self
					).data
				} catch {
					fatalError("\(error)")
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

		} label: {
			Symbols.plus
				.font(
					.system(.headline, design: .rounded)
					.bold()
				)
		}
	}
}
