//
//  PlatformsSection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore
import HackStatModels

struct PlatformsSection: View {
    let submissionsViewModel: SubmissionsViewModel

    var platforms: [Platform] {
        [
            Platform(
                name: "GitHub",
                emoji: "🐙",
                count: submissionsViewModel.submissions
                    .filter { $0.platformType == .github }
                    .reduce(0) { $0 + $1.submissionsCount },
                color: .black.opacity(0.85),
                platformType: .github
            ),
            Platform(
                name: "GitLab",
                emoji: "🦊",
                count: submissionsViewModel.submissions
                    .filter { $0.platformType == .gitlab }
                    .reduce(0) { $0 + $1.submissionsCount },
                color: .orange.opacity(0.8),
                platformType: .gitlab
            ),
            Platform(
                name: "CodeWars",
                emoji: "⚔️",
                count: submissionsViewModel.submissions
                    .filter { $0.platformType == .codewars }
                    .reduce(0) { $0 + $1.submissionsCount },
                color: .red.opacity(0.75),
                platformType: .codewars
            ),
            Platform(
                name: "LeetCode",
                emoji: "💻",
                count: submissionsViewModel.submissions
                    .filter { $0.platformType == .leetcode }
                    .reduce(0) { $0 + $1.submissionsCount },
                color: .blue.opacity(0.8),
                platformType: .leetcode
            )
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PLATFORMS")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(platforms) { platform in
                    PlatformCard(platform: platform)
						.skeleton(RoundedRectangle(cornerRadius: 12), isLoading: submissionsViewModel.isLoading)
						.animation(.easeInOut(duration: 0.5), value: submissionsViewModel.isLoading)
                }
            }
        }
    }
}

#Preview {
    PlatformsSection(
        submissionsViewModel: SubmissionsViewModel.previewInstance,
    )
}
