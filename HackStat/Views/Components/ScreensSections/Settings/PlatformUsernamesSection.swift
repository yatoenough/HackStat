//
//  PlatformUsernamesSection.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 27/10/2025.
//

import SwiftUI
import HackStatCore

struct PlatformUsernamesSection: View {
    let settingsViewModel: Bindable<SettingsViewModel>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PLATFORM USERNAMES")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)

            Toggle("Use same username for all", isOn: settingsViewModel.useSameUsername)
                .padding(14)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)

			if settingsViewModel.useSameUsername.wrappedValue {
                UsernameFieldCard(
                    title: "Universal",
                    emoji: "🌐",
                    color: .blue.opacity(0.8),
                    username: settingsViewModel.universalUsername
                )
                .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
            }

            VStack(spacing: 10) {
                UsernameFieldCard(
                    title: "GitHub",
                    emoji: "🐙",
                    color: .black.opacity(0.85),
                    username: settingsViewModel.githubUsername
                )
                UsernameFieldCard(
                    title: "GitLab",
                    emoji: "🦊",
                    color: .orange.opacity(0.8),
                    username: settingsViewModel.gitlabUsername
                )
                UsernameFieldCard(
                    title: "CodeWars",
                    emoji: "⚔️",
                    color: .red.opacity(0.75),
                    username: settingsViewModel.codewarsUsername
                )
                UsernameFieldCard(
                    title: "LeetCode",
                    emoji: "💻",
                    color: .blue.opacity(0.7),
                    username: settingsViewModel.leetcodeUsername
                )
            }
			.opacity(settingsViewModel.useSameUsername.wrappedValue ? 0.5 : 1)
			.disabled(settingsViewModel.useSameUsername.wrappedValue)
        }
    }
}

#Preview {
	@Bindable var settingsViewModel = SettingsViewModel()
	PlatformUsernamesSection(settingsViewModel: $settingsViewModel)
}
