//
//  SettingsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct SettingsScreen: View {
	@EnvironmentObject var settingsViewModel: SettingsViewModel
	
    var body: some View {
		NavigationStack {
			ScrollView {
				VStack(alignment: .leading) {
					Text("Platform usernames")
						.font(.title2)
						.bold()
					
					Toggle("Use same username for all platforms", isOn: $settingsViewModel.useSameUsername)
						.onChange(of: settingsViewModel.useSameUsername) { _, newValue in
							if newValue == true {
								settingsViewModel.setUniversalUsername(settingsViewModel.username)
							}
						}
					
					if settingsViewModel.useSameUsername {
						PlatformUsernameField(title: "Universal", image: Image(systemName: "globe"), username: $settingsViewModel.username)
							.transition(.opacity)
							.onSubmit {
								settingsViewModel.setUniversalUsername(settingsViewModel.username)
							}
					}
					
					VStack {
						PlatformUsernameField(title: "GitHub", image: Image(.github), username: $settingsViewModel.githubUsername)
						PlatformUsernameField(title: "GitLab", image: Image(.gitlab), username: $settingsViewModel.gitlabUsername)
						PlatformUsernameField(title: "Codewars", image: Image(.codewars), username: $settingsViewModel.codewarsUsername)
						PlatformUsernameField(title: "LeetCode", image: Image(.leetcode), username: $settingsViewModel.leetcodeUsername)
					}
					.opacity(settingsViewModel.useSameUsername ? 0.3 : 1)
					.disabled(settingsViewModel.useSameUsername)
					.padding(.vertical)
				}
				.textInputAutocapitalization(.never)
				.animation(.easeInOut, value: settingsViewModel.useSameUsername)
				.padding()
			}
			.scrollDismissesKeyboard(.immediately)
			.textFieldStyle(.roundedBorder)
			.navigationTitle("Settings")
		}
    }
}

#Preview {
	SettingsScreen()
		.environmentObject(SettingsViewModel())
}
