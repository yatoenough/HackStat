//
//  SettingsViewModel.swift
//  HackStat
//
//  Created by Nikita Shyshkin on 07/09/2025.
//

import SwiftUI
import HackStatModels

@Observable
public class SettingsViewModel {
	private let storage = Storage()

	public var useSameUsername: Bool {
		didSet { storage.useSameUsername = useSameUsername }
	}

	public var universalUsername: String {
		didSet { storage.universalUsername = universalUsername }
	}

	public var githubUsername: String {
		didSet { storage.githubUsername = githubUsername }
	}

	public var gitlabUsername: String {
		didSet { storage.gitlabUsername = gitlabUsername }
	}

	public var codewarsUsername: String {
		didSet { storage.codewarsUsername = codewarsUsername }
	}

	public var leetcodeUsername: String {
		didSet { storage.leetcodeUsername = leetcodeUsername }
	}
	
	public var firstWeekday: Int {
		didSet { storage.firstWeekday = firstWeekday }
	}

	public init() {
		self.useSameUsername = storage.useSameUsername
		self.universalUsername = storage.universalUsername
		self.githubUsername = storage.githubUsername
		self.gitlabUsername = storage.gitlabUsername
		self.codewarsUsername = storage.codewarsUsername
		self.leetcodeUsername = storage.leetcodeUsername
		self.firstWeekday = storage.firstWeekday
	}

	public func setUniversalUsername(_ username: String) {
		githubUsername = username
		gitlabUsername = username
		codewarsUsername = username
		leetcodeUsername = username
	}

	public func resolveUsernames() -> Usernames {
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

public extension SettingsViewModel {
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
