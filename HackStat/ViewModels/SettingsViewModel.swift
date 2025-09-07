//
//  SettingsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
	@AppStorage(Strings.useSameUsernameKey) var useSameUsername = false
	@AppStorage(Strings.universalUsernameKey) var username = ""
	@AppStorage(Strings.githubUsernameKey) var githubUsername = ""
	@AppStorage(Strings.gitlabUsernameKey) var gitlabUsername = ""
	@AppStorage(Strings.codewarsUsernameKey) var codewarsUsername = ""
	@AppStorage(Strings.leetcodeUsernameKey) var leetcodeUsername = ""
	
	func setUniversalUsername(_ username: String) {
		githubUsername = username
		gitlabUsername = username
		codewarsUsername = username
		leetcodeUsername = username
	}
	
	func resolveUsernames() -> Usernames {
		if useSameUsername {
			return Usernames(
				github: username,
				gitlab: username,
				codewars: username,
				leetcode: username
			)
		} else {
			return Usernames(
				github: githubUsername,
				gitlab: gitlabUsername,
				codewars: codewarsUsername,
				leetcode: leetcodeUsername
			)
		}
	}
}
