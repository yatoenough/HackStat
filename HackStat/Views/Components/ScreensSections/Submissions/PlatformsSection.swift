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
                }
            }
        }
    }
}

struct Platform: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let count: Int
    let color: Color
    let platformType: PlatformType
}

struct PlatformCard: View {
    let platform: Platform
    @State private var isPressed = false

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
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPressed ? .blue.opacity(0.7) : Color.clear, lineWidth: 2)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isPressed = false
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
