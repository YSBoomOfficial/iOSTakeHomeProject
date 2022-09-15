//
//  DetailItemView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 15/09/2022.
//

import SwiftUI

struct DetailItemView: View {
	let title: String
	let text: String

	var body: some View {
		Group {
			Text(title)
				.font(
					.system(.body, design: .rounded)
					.weight(.semibold)
				)

			Text(text)
				.font(.system(.subheadline, design: .rounded))
		}
	}
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			DetailItemView(title: "First Name", text: "George")
		}
    }
}
