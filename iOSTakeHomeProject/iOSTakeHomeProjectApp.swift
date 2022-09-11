//
//  iOSTakeHomeProjectApp.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

@main
struct iOSTakeHomeProjectApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

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

				SettingsView()
					.tabItem {
						Label {
							Text("Settings")
						} icon: {
							Symbols.gear
						}
					}
			}
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		#if DEBUG
		print("App Delegate - is UI Testing: \(UITestingHelper.isUITesting)")
		#endif

		return true
	}
}
