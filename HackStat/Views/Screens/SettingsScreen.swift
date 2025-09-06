//
//  SettingsScreen.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 06/09/2025.
//

import SwiftUI

struct SettingsScreen: View {
	@State private var useSameUsername = false
	
	@AppStorage("universalUsername") private var username = ""
	
	@AppStorage("githubUsername") private var githubUsername = ""
	@AppStorage("gitlabUsername") private var gitlabUsername = ""
	@AppStorage("codewarsUsername") private var codewarsUsername = ""
	@AppStorage("leetcodeUsername") private var leetcodeUsername = ""
	
    var body: some View {
		NavigationStack {
			ScrollView {
				VStack(alignment: .leading) {
					Text("Platform usernames")
						.font(.title2)
						.bold()
					
					Toggle("Use same username for all platforms", isOn: $useSameUsername)
					
					if useSameUsername {
						PlatformUsernameField(title: "Universal", image: Image(systemName: "globe"), username: $username)
							.transition(.opacity)
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
}

#Preview {
	SettingsScreen()
}
