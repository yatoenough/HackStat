//
//  SettingsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

import SwiftUI

@Observable
class SettingsViewModel {
	private let storage = Storage()

	var useSameUsername: Bool {
		didSet { storage.useSameUsername = useSameUsername }
	}

	var universalUsername: String {
		didSet { storage.universalUsername = universalUsername }
	}

	var githubUsername: String {
		didSet { storage.githubUsername = githubUsername }
	}

	var gitlabUsername: String {
		didSet { storage.gitlabUsername = gitlabUsername }
	}

	var codewarsUsername: String {
		didSet { storage.codewarsUsername = codewarsUsername }
	}

	var leetcodeUsername: String {
		didSet { storage.leetcodeUsername = leetcodeUsername }
	}
	
	var firstWeekday: Int {
		didSet { storage.firstWeekday = firstWeekday }
	}

	init() {
		self.useSameUsername = storage.useSameUsername
		self.universalUsername = storage.universalUsername
		self.githubUsername = storage.githubUsername
		self.gitlabUsername = storage.gitlabUsername
		self.codewarsUsername = storage.codewarsUsername
		self.leetcodeUsername = storage.leetcodeUsername
		self.firstWeekday = storage.firstWeekday
	}

	func setUniversalUsername(_ username: String) {
		githubUsername = username
		gitlabUsername = username
		codewarsUsername = username
		leetcodeUsername = username
	}

	func resolveUsernames() -> Usernames {
		if useSameUsername {
			return Usernames(
				github: universalUsername,
				gitlab: universalUsername,
				codewars: universalUsername,
				leetcode: universalUsername
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

extension SettingsViewModel {
	private class Storage {
		@AppStorage(Strings.useSameUsernameKey) var useSameUsername = false
		@AppStorage(Strings.universalUsernameKey) var universalUsername = ""
		@AppStorage(Strings.githubUsernameKey) var githubUsername = ""
		@AppStorage(Strings.gitlabUsernameKey) var gitlabUsername = ""
		@AppStorage(Strings.codewarsUsernameKey) var codewarsUsername = ""
		@AppStorage(Strings.leetcodeUsernameKey) var leetcodeUsername = ""
		@AppStorage(Strings.firstWeekdayKey) var firstWeekday = 1
	}
}
