//
//  PillView.swift
//  iOSTakeHomeProject
//
//  Created by Yash Shah on 10/09/2022.
//

import SwiftUI

struct PillView: View {
	let id: Int

    var body: some View {
		Text("#\(id)")
			.font(.system(.caption, design: .rounded).bold())
			.foregroundColor(.white)
			.padding(.horizontal, 9)
			.padding(.vertical, 4)
			.background(Theme.pill, in: Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 1)
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
			.padding()
    }
}
