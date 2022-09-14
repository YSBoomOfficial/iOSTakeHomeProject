//
//  DetailView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct DetailView: View {
	let userID: Int
	@StateObject private var vm: DetailViewModel

	init(userID: Int) {
		self.userID = userID

		#if DEBUG
		if UITestingHelper.isUITesting {
			let mock: NetworkingManaging = UITestingHelper.isDetailsNetworkingSuccessful ? NetworkingManagerUserDetailResponseSuccessMock() : NetworkingManagerUserDetailResponseFailureMock()
			_vm = .init(wrappedValue: .init(networkingManager: mock))
		} else {
			_vm = .init(wrappedValue: .init())
		}
		#else
		_vm = .init(wrappedValue: .init())
		#endif
	}

	var body: some View {
		ZStack {
			background

			if vm.isLoading {
				ProgressView("Loading…")
			} else {
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
		}
		.navigationTitle("Details")
		.task {
			await vm.fetchDetails(for: userID)
		}
		.alert(isPresented: $vm.hasError, error: vm.error) {}
	}
}

struct DetailView_Previews: PreviewProvider {
	private static var previewUserID: Int {
		try! StaticJSONMapper.decode(
			file: "SingleUserData",
			type: UserDetailResponse.self
		).data.id
	}

	static var previews: some View {
		DetailView(userID: previewUserID)
			.embedInNavigation()
			.preferredColorScheme(.dark)

	}
}

private extension DetailView {
	var background: some View {
		Theme.background.edgesIgnoringSafeArea(.top)
	}

	@ViewBuilder
	var avatar: some View {
		if let avatarAbsStr = vm.userInfo?.data.avatar,
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

		Text(vm.userInfo?.data.firstName ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	@ViewBuilder
	var lastName: some View {
		Text("Last Name")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(vm.userInfo?.data.lastName ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	@ViewBuilder
	var email: some View {
		Text("Email")
			.font(
				.system(.body, design: .rounded)
				.weight(.semibold)
			)

		Text(vm.userInfo?.data.email ?? "-")
			.font(.system(.subheadline, design: .rounded))
	}

	var general: some View {
		VStack(alignment: .leading, spacing: 8) {
			PillView(id: vm.userInfo?.data.id ?? 0)

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
		if let supportAbsStr = vm.userInfo?.support.url,
		   let supportURL = URL(string: supportAbsStr),
		   let supportText = vm.userInfo?.support.text {
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
