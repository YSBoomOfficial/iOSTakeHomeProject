//
//  View+Navigation.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 14/09/2022.
//

import SwiftUI

extension View {
	@ViewBuilder
	func embedInNavigation(withTitle title: String = "") -> some View {
		if #available(iOS 16.0, *) {
			NavigationStack {
				self.navigationTitle(title)
			}
		} else {
			NavigationView {
				self.navigationTitle(title)
			}
		}
	}
}
