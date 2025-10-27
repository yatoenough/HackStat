//
//  GradientText.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI

struct GradientText: View {
	let text: String
	
	var body: some View {
		Text(text)
			.font(.system(size: 36, weight: .heavy))
			.foregroundStyle(
				LinearGradient(
					colors: [.blue.opacity(0.7), .purple.opacity(0.8)],
					startPoint: .leading,
					endPoint: .trailing
				)
			)

	}
}

#Preview {
	GradientText(text: "Text")
}
