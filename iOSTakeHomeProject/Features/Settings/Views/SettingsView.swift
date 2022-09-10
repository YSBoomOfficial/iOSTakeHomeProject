//
//  SettingsView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct SettingsView: View {
	@AppStorage(UserDefaultsKeys.hapticsEnabled) var hapticsEnabled = true

    var body: some View {
		NavigationView {
			Form {
				haptics
			}
			.navigationTitle("Settings")
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private extension SettingsView {
	var haptics: some View {
		Toggle("Enable Haptics", isOn: $hapticsEnabled)
	}
}
