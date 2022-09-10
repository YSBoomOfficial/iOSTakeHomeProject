//
//  CheckmarkPopoverView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct CheckmarkPopoverView: View {
	var body: some View {
		Symbols.checkmark
			.font(
				.system(.largeTitle, design: .rounded)
				.bold()
			)
			.padding()
			.background(
				.thinMaterial,
				in: RoundedRectangle(cornerRadius: 10, style: .continuous)
			)
	}
}

struct CheckmarkPopoverView_Previews: PreviewProvider {
	static var previews: some View {
		CheckmarkPopoverView()
			.previewLayout(.sizeThatFits)
			.padding()
			.preferredColorScheme(.dark)
	}
}
