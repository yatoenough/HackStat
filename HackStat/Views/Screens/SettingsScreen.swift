//
//  SettingsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct SettingsScreen: View {
	@AppStorage(Strings.useSameUsernameKey) private var useSameUsername = false
	
	@AppStorage(Strings.universalUsernameKey) private var username = ""
	
	@AppStorage(Strings.githubUsernameKey) private var githubUsername = ""
	@AppStorage(Strings.gitlabUsernameKey) private var gitlabUsername = ""
	@AppStorage(Strings.codewarsUsernameKey) private var codewarsUsername = ""
	@AppStorage(Strings.leetcodeUsernameKey) private var leetcodeUsername = ""
	
    var body: some View {
		NavigationStack {
			ScrollView {
				VStack(alignment: .leading) {
					Text("Platform usernames")
						.font(.title2)
						.bold()
					
					Toggle("Use same username for all platforms", isOn: $useSameUsername)
						.onChange(of: useSameUsername) { _, newValue in
							if newValue == true {
								setUniversalUsername(username)
							}
						}
					
					if useSameUsername {
						PlatformUsernameField(title: "Universal", image: Image(systemName: "globe"), username: $username)
							.transition(.opacity)
							.onSubmit {
								setUniversalUsername(username)
							}
					}
					
					VStack {
						PlatformUsernameField(title: "GitHub", image: Image(.github), username: $githubUsername)
						PlatformUsernameField(title: "GitLab", image: Image(.gitlab), username: $gitlabUsername)
						PlatformUsernameField(title: "Codewars", image: Image(.codewars), username: $codewarsUsername)
						PlatformUsernameField(title: "LeetCode", image: Image(.leetcode), username: $leetcodeUsername)
					}
					.opacity(useSameUsername ? 0.3 : 1)
					.disabled(useSameUsername)
					.padding(.vertical)
				}
				.animation(.easeInOut, value: useSameUsername)
				.padding()
			}
			.textFieldStyle(.roundedBorder)
			.navigationTitle("Settings")
		}
    }
	
	func setUniversalUsername(_ username: String) {
		githubUsername = username
		gitlabUsername = username
		codewarsUsername = username
		leetcodeUsername = username
	}
}

#Preview {
	SettingsScreen()
}
