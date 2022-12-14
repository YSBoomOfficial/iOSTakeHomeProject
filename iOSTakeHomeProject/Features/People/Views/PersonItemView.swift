//
//  PersonItemView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PersonItemView: View {
	let user: User

    var body: some View {
		VStack(spacing: .zero) {
			personImage

			VStack(alignment: .leading) {

				PillView(id: user.id)

				Text("\(user.firstName) \(user.lastName)")
					.foregroundColor(Theme.text)
					.font(.system(.body, design: .rounded))

			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 8)
			.padding(.vertical, 5)
			.background(Theme.detailBackground)
		}
		.clipShape(
			RoundedRectangle(cornerRadius: 16, style: .continuous)
		)
		.shadow(
			color: Theme.text.opacity(0.1),
			radius: 2,
			x: 0,
			y: 1
		)
    }
}

struct PersonItemView_Previews: PreviewProvider {
	static var previewUser: User {
		try! StaticJSONMapper.decode(
			file: "SingleUserData",
			type: UserDetailResponse.self
		).data
	}
    static var previews: some View {
		PersonItemView(user: previewUser)
			.preferredColorScheme(.dark)
			.frame(width: 250)
    }
}

private extension PersonItemView {
	var personImage: some View {
		AsyncImage(url: .init(string: user.avatar)) { image in
			image
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(height: 130)
				.clipped()
		} placeholder: {
			ProgressView()
		}
	}
}
