//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PeopleView: View {
	private let columns = Array(repeating: GridItem(.flexible()), count: 2)

	var body: some View {
		NavigationView {
			ZStack {
				background
				ScrollView {
					LazyVGrid(columns: columns, spacing: 16) {
						ForEach(0...5, id: \.self) { item in
							PersonItemView(user: item)
						}
					}
					.padding()
				}
			}
			.navigationTitle("People")
			.toolbar {
				ToolbarItem(placement: .primaryAction) { create }
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
