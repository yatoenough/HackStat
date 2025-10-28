//
//  PlatformCard.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 28/10/2025.
//

import SwiftUI

struct PlatformCard: View {
	let platform: Platform

	var body: some View {
		HStack(spacing: 10) {
			ZStack {
				RoundedRectangle(cornerRadius: 8)
					.fill(platform.color)
					.frame(width: 32, height: 32)

				Text(platform.emoji)
					.font(.system(size: 18))
			}

			VStack(alignment: .leading, spacing: 2) {
				Text(platform.name)
					.font(.system(size: 13, weight: .semibold))
					.foregroundColor(.primary)

				Text("\(platform.count) submissions")
					.font(.system(size: 11))
					.foregroundColor(.gray)
			}

			Spacer()
		}
		.padding(14)
		.background(.ultraThinMaterial)
		.cornerRadius(12)
	}
}

import HackStatModels

#Preview {
	PlatformCard(
		platform: Platform(
			name: "Platform",
			emoji: "🌐",
			count: 23,
			color: .black,
			platformType: .codewars
		)
	)
}
