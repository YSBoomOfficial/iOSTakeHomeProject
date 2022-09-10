//
//  iOSTakeHomeProjectApp.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

@main
struct iOSTakeHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
			TabView {
				PeopleView()
					.tabItem {
						Label {
							Text("Home")
						} icon: {
							Symbols.person
						}

					}
			}
        }
    }
}
