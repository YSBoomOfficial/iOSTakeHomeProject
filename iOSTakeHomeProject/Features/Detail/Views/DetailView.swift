//
//  DetailView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct DetailView: View {
	@State private var userInfo: UserDetailResponse?

	var body: some View {
		ZStack {
			background
			ScrollView {
				VStack(alignment: .leading, spacing: 18) {
					avatar
					Group {
						general
						link
					}
					.padding(.horizontal, 8)
					.padding(.vertical, 18)
					.background(
						Theme.detailBackground,
						in: RoundedRectangle(cornerRadius: 16, style: .continuous)
					)

				}.padding()
			}
		}
		.navigationTitle("Detail")
		.onAppear {
			userInfo = try? StaticJSONMapper.decode(
				file: "SingleUserData",
				type: UserDetailResponse.self
			)
		}
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			DetailView()
				.preferredColorScheme(.dark)
		}
	}
}

private extension DetailView {
	var background: some View {
		Theme.background.edgesIgnoringSafeArea(.top)
	}

	@ViewBuilder
	var avatar: some View {
		if let avatarAbsStr = userInfo?.data.avatar,
		   let avatarURL = URL(string: avatarAbsStr) {
			AsyncImage(url: avatarURL) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: 250)
					.clipped()
			} placeholder: {
				ProgressView()
			}
			.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
		}
	}

	@ViewBuilder
	var firstName: some View {
		Text("First Name")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(userInfo?.data.firstName ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	@ViewBuilder
	var lastName: some View {
		Text("Last Name")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(userInfo?.data.lastName ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	@ViewBuilder
	var email: some View {
		Text("Email")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(userInfo?.data.email ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	var general: some View {
		VStack(alignment: .leading, spacing: 8) {
			PillView(id: userInfo?.data.id ?? 0)

			Group {
				firstName
				Divider()
				lastName
				Divider()
				email
			}
			.foregroundColor(Theme.text)
		}
	}

	@ViewBuilder
	var link: some View {
		if let supportAbsStr = userInfo?.support.url,
		   let supportURL = URL(string: supportAbsStr),
		   let supportText = userInfo?.support.text {
			Link(destination: supportURL) {
				VStack(alignment: .leading, spacing: 8) {
					Text(supportText)
						.foregroundColor(Theme.text)
						.font(
							.system(.body, design: .rounded)
							.weight(.semibold)
						)
						.multilineTextAlignment(.leading)
					Text(supportAbsStr)
						.underline()
				}

				Spacer()

				Symbols.link.font(.system(.title3, design: .rounded))
			}
		}
	}
}